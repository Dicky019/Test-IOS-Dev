//
//  BluetoothDevicesList.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothDevicesList: View {
  let devices: [BluetoothDevice]
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(devices) { device in
          BluetoothDeviceRow(device: device)
          
          if device.id != devices.last?.id {
            Divider()
          }
        }
      }
    }
  }
}
