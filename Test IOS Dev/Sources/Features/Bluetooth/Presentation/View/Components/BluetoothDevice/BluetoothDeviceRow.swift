//
//  BluetoothDeviceRow.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothDeviceRow: View {
  let device: BluetoothDevice
  
  var body: some View {
    HStack {
      BluetoothDeviceIcon(
        deviceType: device.deviceType.rawValue,
        isConnected: device.isConnected
      )
      
      BluetoothDeviceInfo(device: device)
      
      Spacer()
      
      BluetoothDeviceStatus(
        isConnected: device.isConnected,
        rssi: device.rssi
      )
    }
    .padding(.vertical, 8)
  }
}
