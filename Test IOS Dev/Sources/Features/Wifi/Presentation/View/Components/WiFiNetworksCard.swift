//
//  WiFiNetworksCard.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworksCard: View {
  @ObservedObject var viewModel: WiFiViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      InfoHeader(count: viewModel.networks.count)
      WiFiNetworksList(networks: viewModel.networks)
    }
    .padding()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(12)
  }
}
