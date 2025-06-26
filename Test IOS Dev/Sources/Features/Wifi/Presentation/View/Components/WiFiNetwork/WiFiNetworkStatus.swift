//
//  WiFiNetworkStatus.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworkStatus: View {
  let isConnected: Bool
  let signalStrength: Int
  
  var body: some View {
    VStack(alignment: .trailing, spacing: 4) {
      if isConnected {
        Image(systemName: "checkmark.circle.fill")
          .foregroundColor(.green)
      } else {
        SignalStrengthIndicator(signalStrength: signalStrength)
      }
      
      Text(isConnected ? "Connected" : signalQuality)
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }
  
  private var signalQuality: String {
    let strength = abs(signalStrength)
    if strength < 50 {
      return "Excellent"
    } else if strength < 70 {
      return "Good"
    } else if strength < 85 {
      return "Fair"
    } else {
      return "Poor"
    }
  }
}
