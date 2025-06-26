//
//  BluetoothDevicesCard.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothDevicesCard: View {
  @ObservedObject var viewModel: BluetoothViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      InfoHeader(count: viewModel.devices.count)
      BluetoothDevicesList(devices: viewModel.devices)
    }
  }
}
