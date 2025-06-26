//
//  BluetoothStatusInfo.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothStatusInfo: View {
  let bluetoothState: String
  let isScanning: Bool
  let deviceCount: Int
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      InfoRow(
        label: "Status",
        value: bluetoothState == "Powered On" ? "Ready" : "Not Available"
      )
      
      InfoRow(
        label: "Scanning",
        value: isScanning ? "Active" : "Inactive"
      )
      
      InfoRow(
        label: "Devices Found",
        value: "\(deviceCount)"
      )
    }
  }
}
