//
//  WiFiViewModel.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI
import Combine

@MainActor
final class WiFiViewModel: ObservableObject {
  // Published properties
  @Published private(set) var networks: [WiFiInfo] = []
  @Published private(set) var currentNetwork: WiFiInfo?
  @Published private(set) var networkStatus: NetworkStatus = .unknown
  @Published private(set) var locationPermissionStatus: LocationPermissionStatus = .unknown
  @Published private(set) var isScanning = false
  @Published private(set) var errorMessage: String?
  
  // Use cases
  private let getWiFiInfoUseCase: GetWiFiInfoUseCase
  private let scanWiFiNetworksUseCase: ScanWiFiNetworksUseCase
  private let monitorNetworkStatusUseCase: MonitorNetworkStatusUseCase
  private let checkLocationPermissionUseCase: CheckLocationPermissionUseCase
  
  // Cancellables
  private var networkStatusTask: Task<Void, Never>?
  
  init() {
    self.getWiFiInfoUseCase = DIContainer.shared.getWiFiInfoUseCase
    self.scanWiFiNetworksUseCase = DIContainer.shared.scanWiFiNetworksUseCase
    self.monitorNetworkStatusUseCase = DIContainer.shared.monitorNetworkStatusUseCase
    self.checkLocationPermissionUseCase = DIContainer.shared.checkLocationPermissionUseCase
    
    Task {
      await loadInitialData()
      await observeNetworkStatus()
    }
  }
  
  deinit {
    networkStatusTask?.cancel()
  }
  
  // Public methods
  func scanForNetworks() async {
    errorMessage = nil
    
    // Check permission first
    if locationPermissionStatus != .authorized {
      if locationPermissionStatus == .notDetermined {
        let status = await checkLocationPermissionUseCase.requestPermission()
        locationPermissionStatus = status
        
        if status != .authorized {
          errorMessage = "Location permission is required to scan for WiFi networks"
          return
        }
      } else {
        errorMessage = "Location permission is required to scan for WiFi networks"
        return
      }
    }
    
    isScanning = true
    networks.removeAll()
    
    do {
      // Get current network first
      if let current = await getWiFiInfoUseCase.execute() {
        currentNetwork = current
        if !networks.contains(where: { $0.id == current.id }) {
          networks.append(current)
        }
      }
      
      // Scan for other networks
      let scannedNetworks = try await scanWiFiNetworksUseCase.execute()
      
      for network in scannedNetworks {
        if !networks.contains(where: { $0.id == network.id }) {
          networks.append(network)
        }
      }
      
      // Sort networks
      networks.sort { network1, network2 in
        if network1.isConnected != network2.isConnected {
          return network1.isConnected
        }
        return network1.signalStrength > network2.signalStrength
      }
    } catch {
      errorMessage = error.localizedDescription
    }
    
    isScanning = false
  }
  
  func stopScanning() {
    scanWiFiNetworksUseCase.stopScanning()
    isScanning = false
  }
  
  func refreshStatus() async {
    locationPermissionStatus = checkLocationPermissionUseCase.execute()
    networkStatus = monitorNetworkStatusUseCase.execute()
    currentNetwork = await getWiFiInfoUseCase.execute()
  }
  
  // Private methods
  private func loadInitialData() async {
    locationPermissionStatus = checkLocationPermissionUseCase.execute()
    networkStatus = monitorNetworkStatusUseCase.execute()
    currentNetwork = await getWiFiInfoUseCase.execute()
  }
  
  private func observeNetworkStatus() async {
    networkStatusTask = Task {
      for await status in monitorNetworkStatusUseCase.observeStatus() {
        networkStatus = status
      }
    }
  }
}
