//
//  WiFiInfo.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 25/06/25.
//

import Foundation

struct WiFiInfo: Equatable, Identifiable {
  let id: String
  let ssid: String
  let bssid: String?
  let signalStrength: Int
  let isSecure: Bool
  let frequency: String?
  let isConnected: Bool
  let discoveredAt: Date
  
  init(
    ssid: String,
    bssid: String? = nil,
    signalStrength: Int,
    isSecure: Bool,
    frequency: String? = nil,
    isConnected: Bool = false
  ) {
    self.id = "\(ssid)-\(bssid ?? UUID().uuidString)"
    self.ssid = ssid
    self.bssid = bssid
    self.signalStrength = signalStrength
    self.isSecure = isSecure
    self.frequency = frequency
    self.isConnected = isConnected
    self.discoveredAt = Date()
  }
}

enum WiFiError: LocalizedError {
  case locationPermissionDenied
  case scanningFailed
  case networkUnavailable
  
  var errorDescription: String? {
    switch self {
    case .locationPermissionDenied:
      return "Location permission is required to scan for WiFi networks"
    case .scanningFailed:
      return "Failed to scan for networks"
    case .networkUnavailable:
      return "Network is unavailable"
    }
  }
}
