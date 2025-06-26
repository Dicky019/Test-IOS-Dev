//
//  BluetoothDeviceIcon.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct BluetoothDeviceIcon: View {
  let deviceType: String
  let isConnected: Bool
  
  var body: some View {
    Image(systemName: deviceIcon)
      .foregroundColor(isConnected ? .green : .blue)
      .frame(width: 30)
  }
  
  private var deviceIcon: String {
    switch deviceType.lowercased() {
    case "headphones", "airpods":
      return "headphones"
    case "speaker":
      return "speaker.wave.2"
    case "keyboard":
      return "keyboard"
    case "mouse":
      return "computermouse"
    case "watch":
      return "applewatch"
    case "phone":
      return "iphone"
    case "computer", "mac":
      return "desktopcomputer"
    default:
      return "dot.radiowaves.left.and.right"
    }
  }
}
