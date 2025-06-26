//
//  WiFiScanButton.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiScanButton: View {
  @ObservedObject var viewModel: WiFiViewModel
  
  var body: some View {
    Button(action: {
      Task {
        if viewModel.isScanning {
          viewModel.stopScanning()
        } else {
          await viewModel.scanForNetworks()
        }
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
      .shadow(radius: 4)
    }
    .padding(.horizontal)
    .padding(.bottom, 30)
    .disabled(isDisabled)
  }
  
  private var buttonIcon: String {
    viewModel.isScanning ? "stop.circle.fill" : "magnifyingglass"
  }
  
  private var buttonText: String {
    viewModel.isScanning ? "Stop Scanning" : "Scan for Networks"
  }
  
  private var buttonColor: Color {
    viewModel.isScanning ? .red : .blue
  }
  
  private var isDisabled: Bool {
    viewModel.locationPermissionStatus == .denied ||
    viewModel.locationPermissionStatus == .restricted
  }
}
