//
//  BluetoothScanButton.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothScanButton: View {
  @ObservedObject var viewModel: BluetoothViewModel
  
  var body: some View {
    Button(action: {
      if viewModel.isScanning {
        viewModel.stopScanning()
      } else {
        viewModel.startScanning()
      }
    }) {
      HStack {
        Image(systemName: buttonIcon)
        Text(buttonText)
      }
      .font(.headline)
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .padding()
      .background(buttonColor)
      .cornerRadius(12)
    }
    .disabled(viewModel.bluetoothState != "Powered On")
    .padding(.all, 20)
  }
  
  private var buttonIcon: String {
    viewModel.isScanning ? "stop.circle" : "magnifyingglass"
  }
  
  private var buttonText: String {
    viewModel.isScanning ? "Stop Scanning" : "Scan for Devices"
  }
  
  private var buttonColor: Color {
    viewModel.isScanning ? .red : .blue
  }
}
