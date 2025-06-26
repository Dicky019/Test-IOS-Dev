//
//  WiFiNetworkRow.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworkRow: View {
  let network: WiFiInfo
  
  var body: some View {
    HStack {
      WiFiNetworkIcon(
        signalStrength: network.signalStrength,
        isConnected: network.isConnected
      )
      
      WiFiNetworkInfo(network: network)
      
      Spacer()
      
      WiFiNetworkStatus(
        isConnected: network.isConnected,
        signalStrength: network.signalStrength
      )
    }
    .padding(.vertical, 8)
  }
}
