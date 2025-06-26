//
//  BluetoothEmptyStateView.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothEmptyStateView: View {
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "magnifyingglass")
        .font(.system(size: 40))
        .foregroundColor(.gray)
      
      Text("No devices found")
        .font(.headline)
        .foregroundColor(.gray)
      
      Text("Tap 'Scan for Devices' to start searching for nearby Bluetooth devices")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding(.top, 48)
  }
}
