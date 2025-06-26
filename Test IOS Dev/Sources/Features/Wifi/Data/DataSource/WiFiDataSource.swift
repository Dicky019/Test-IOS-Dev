//
//  WiFiDataSource.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import CoreLocation
import NetworkExtension

protocol WiFiDataSourceProtocol {
  func getCurrentNetworkInfo() -> WiFiInfo?
  func scanForNetworks() async throws -> [WiFiInfo]
  func stopScanning()
}

final class WiFiDataSource: WiFiDataSourceProtocol {
  private var scanTimer: Timer?
  
  func getCurrentNetworkInfo() -> WiFiInfo? {
    guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return nil }
    
    for interface in interfaces {
      guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else { continue }
      
      if let ssid = info[kCNNetworkInfoKeySSID as String] as? String {
        let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String
        
        return WiFiInfo(
          ssid: ssid,
          bssid: bssid,
          signalStrength: -30,
          isSecure: true,
          frequency: "2.4 GHz",
          isConnected: true
        )
      }
    }
    return nil
  }
  
  func scanForNetworks() async throws -> [WiFiInfo] {
//    TODO: iOS doesn't allow direct WiFi scanning without NEHotspotHelper entitlement
    return await simulateNetworkDiscovery()
  }
  
  func stopScanning() {
    scanTimer?.invalidate()
    scanTimer = nil
  }
}

// MARK: - Updated WiFiDataSource.swift (relevant section)
extension WiFiDataSource {
  private func simulateNetworkDiscovery() async -> [WiFiInfo] {
    let sampleNetworks = [
      ("fh_9a5d68_5G", -45, true, "5 GHz", BSSIDGenerator.VendorPrefix.tpLink),
      ("Dicky's iPhone", -55, true, "2.4 GHz", BSSIDGenerator.VendorPrefix.apple),
      ("sasna", -65, false, "2.4 GHz", BSSIDGenerator.VendorPrefix.tpLink),
    ]
    
    var networks: [WiFiInfo] = []
    
    // Add current network first if available
    if let currentNetwork = getCurrentNetworkInfo() {
      networks.append(currentNetwork)
    }
    
    // Simulate discovering networks with delays
    for (ssid, rssi, isSecure, freq, vendorPrefix) in sampleNetworks {
      // Skip if this is the current network
      if networks.first?.ssid == ssid {
        continue
      }
      
      let network = WiFiInfo(
        ssid: ssid,
        bssid: BSSIDGenerator.generate(withVendorPrefix: vendorPrefix),
        signalStrength: rssi,
        isSecure: isSecure,
        frequency: freq,
        isConnected: false
      )
      networks.append(network)
      
      // Simulate discovery delay
      try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    }
    
    return networks
  }
}
