//
//  NetworkStatus.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 25/06/25.
//

enum NetworkStatus: Equatable {
  case connected(type: ConnectionType)
  case disconnected
  case unknown
  
  enum ConnectionType: String {
    case wifi = "WiFi"
    case cellular = "Cellular"
    case ethernet = "Ethernet"
  }
  
  var displayText: String {
    switch self {
    case .connected(let type):
      return type.rawValue
    case .disconnected:
      return "No Connection"
    case .unknown:
      return "Unknown"
    }
  }
}
