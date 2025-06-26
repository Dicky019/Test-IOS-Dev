//
//  WiFiNetworkInfo.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworkInfo: View {
  let network: WiFiInfo
  
  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      // Network Name and Security
      HStack {
        Text(network.ssid)
          .font(.subheadline)
          .fontWeight(.medium)
        
        if network.isSecure {
          Image(systemName: "lock.fill")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      
      // Signal and Frequency
      HStack(spacing: 12) {
        Text("Signal: \(network.signalStrength) dBm")
          .font(.caption)
          .foregroundColor(.secondary)
        
        if let frequency = network.frequency {
          Text(frequency)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      
      // BSSID if available
      if let bssid = network.bssid {
        Text("BSSID: \(bssid)")
          .font(.caption2)
          .foregroundColor(.secondary.opacity(0.7))
      }
    }
  }
}
