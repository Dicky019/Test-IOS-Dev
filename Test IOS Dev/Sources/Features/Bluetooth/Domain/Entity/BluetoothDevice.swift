//
//  BluetoothDevice.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice: Hashable, Identifiable {
  let id: String
  let name: String
  let identifier: String?
  let rssi: Int
  let deviceType: DeviceType
  let isConnected: Bool
  let discoveredAt: Date
  let services: [String]
  
  enum DeviceType: String, CaseIterable {
    case headphones = "Headphones"
    case speaker = "Speaker"
    case keyboard = "Keyboard"
    case mouse = "Mouse"
    case watch = "Watch"
    case phone = "Phone"
    case computer = "Computer"
    case unknown = "Unknown"
  }
  
  init(
    name: String,
    identifier: String? = nil,
    rssi: Int,
    deviceType: DeviceType = .unknown,
    isConnected: Bool = false,
    services: [String] = []
  ) {
    self.id = identifier ?? UUID().uuidString
    self.name = name
    self.identifier = identifier
    self.rssi = rssi
    self.deviceType = deviceType
    self.isConnected = isConnected
    self.discoveredAt = Date()
    self.services = services
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
    lhs.id == rhs.id
  }
}
