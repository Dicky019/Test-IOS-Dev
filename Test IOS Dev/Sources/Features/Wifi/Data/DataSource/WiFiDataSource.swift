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
    // Since iOS doesn't allow direct WiFi scanning, simulate it
    return await simulateNetworkDiscovery()
  }
  
  func stopScanning() {
    scanTimer?.invalidate()
    scanTimer = nil
  }
  
  private func simulateNetworkDiscovery() async -> [WiFiInfo] {
    let sampleNetworks = [
      ("HomeWiFi_5G", -45, true, "5 GHz"),
      ("OfficeNetwork", -55, true, "2.4 GHz"),
      ("Guest_Network", -65, false, "2.4 GHz"),
      ("Cafe_WiFi", -70, false, "2.4 GHz"),
      ("Neighbor_5G", -75, true, "5 GHz"),
      ("Public_Hotspot", -80, false, "2.4 GHz"),
      ("Airport_WiFi", -85, false, "2.4 GHz")
    ]
    
    var networks: [WiFiInfo] = []
    
    // Add current network first
    if let currentNetwork = getCurrentNetworkInfo() {
      networks.append(currentNetwork)
    }
    
    // Add simulated networks with delay
    for (ssid, rssi, isSecure, freq) in sampleNetworks {
      let network = WiFiInfo(
        ssid: ssid,
        bssid: "00:00:00:00:00:\(String(format: "%02X", Int.random(in: 0...255)))",
        signalStrength: rssi,
        isSecure: isSecure,
        frequency: freq
      )
      networks.append(network)
      
      // Simulate delay between discoveries
      try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    }
    
    return networks
  }
}
