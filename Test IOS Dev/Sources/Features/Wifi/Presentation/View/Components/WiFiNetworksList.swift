//
//  WiFiNetworksList.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworksList: View {
  let networks: [WiFiInfo]
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(networks) { network in
        WiFiNetworkRow(network: network)
        
        if network.id != networks.last?.id {
          Divider()
            .padding(.leading, 40)
        }
      }
    }
  }
}
