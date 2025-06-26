//
//  BluetoothStatusHeader.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothStatusHeader: View {
  let bluetoothState: String
  
  var body: some View {
    HStack {
      Image(systemName: "antenna.radiowaves.left.and.right")
        .font(.title2)
        .foregroundColor(.blue)
      
      Text("Bluetooth")
        .font(.title2)
        .fontWeight(.semibold)
      
      Spacer()
      
      StatusBadge(
        text: bluetoothState,
        color: bluetoothState == "Powered On" ? .green : .red
      )
    }
  }
}
