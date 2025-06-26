//
//  BluetoothView.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothView: View {
  @StateObject private var viewModel: BluetoothViewModel = BluetoothViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 20) {
          BluetoothStatusCard(viewModel: viewModel)
          
          if !viewModel.devices.isEmpty {
            BluetoothDevicesCard(viewModel: viewModel)
          }
          
          if viewModel.devices.isEmpty && !viewModel.isScanning {
            BluetoothEmptyStateView()
          }
        }
        .padding(.top, 24)
        .padding(.horizontal, 20)
      }
      .navigationTitle("Bluetooth Scanner")
      .safeAreaInset(edge: .bottom) {
        BluetoothScanButton(viewModel: viewModel)
      }
    }
  }
}
