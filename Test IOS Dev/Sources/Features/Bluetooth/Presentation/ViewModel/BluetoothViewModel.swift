//
//  BluetoothViewModel.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import Combine

class BluetoothViewModel: ObservableObject {
  @Published var devices: [BluetoothDevice] = []
  @Published var isScanning = false
  @Published var bluetoothState = "Unknown"
  
  private let startScanningUseCase: StartScanningUseCase
  private let stopScanningUseCase: StopScanningUseCase
  private let getBluetoothDevicesUseCase: GetBluetoothDevicesUseCase
  private let monitorBluetoothStateUseCase: MonitorBluetoothStateUseCase
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    self.startScanningUseCase = DIContainer.shared.startScanningUseCase
    self.stopScanningUseCase = DIContainer.shared.stopScanningUseCase
    self.getBluetoothDevicesUseCase = DIContainer.shared.getBluetoothDevicesUseCase
    self.monitorBluetoothStateUseCase = DIContainer.shared.monitorBluetoothStateUseCase
    
    subscribeToBluetoothState()
    subscribeToDevices()
  }
  
  func startScanning() {
    isScanning = true
    startScanningUseCase.execute()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
      self?.stopScanning()
    }
  }
  
  func stopScanning() {
    isScanning = false
    stopScanningUseCase.execute()
  }
  
  private func subscribeToBluetoothState() {
    monitorBluetoothStateUseCase.execute()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.bluetoothState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToDevices() {
    getBluetoothDevicesUseCase.execute()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] devices in
        self?.devices = devices
      }
      .store(in: &cancellables)
  }
}
