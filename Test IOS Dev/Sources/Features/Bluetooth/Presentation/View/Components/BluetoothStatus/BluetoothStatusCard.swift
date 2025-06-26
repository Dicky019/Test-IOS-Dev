//
//  BluetoothStatusCard.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothStatusCard: View {
  @ObservedObject var viewModel: BluetoothViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      // Header
      BluetoothStatusHeader(bluetoothState: viewModel.bluetoothState)
      
      // Status Info
      BluetoothStatusInfo(
        bluetoothState: viewModel.bluetoothState,
        isScanning: viewModel.isScanning,
        deviceCount: viewModel.devices.count
      )
      
      // Scanning Progress
      if viewModel.isScanning {
        ScanningProgress(scaningType: "Bluetooth")
      }
    }
  }
}
