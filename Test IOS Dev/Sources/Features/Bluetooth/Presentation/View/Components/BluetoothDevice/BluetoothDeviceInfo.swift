//
//  BluetoothDeviceInfo.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothDeviceInfo: View {
  let device: BluetoothDevice
  
  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(device.name)
        .font(.subheadline)
        .fontWeight(.medium)
      
      if let identifier = device.identifier {
        Text(identifier)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      
      HStack(spacing: 12) {
        Text("Signal: \(device.rssi) dBm")
          .font(.caption)
          .foregroundColor(.secondary)
        
        if !device.deviceType.rawValue.isEmpty {
          Text(device.deviceType.rawValue)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}
