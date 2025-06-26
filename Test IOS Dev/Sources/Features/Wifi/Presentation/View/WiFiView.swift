//
//  WiFiView.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiView: View {
  @StateObject private var viewModel: WiFiViewModel = WiFiViewModel()
  
  var body: some View {
    NavigationView {
      ZStack {
        Color(.systemBackground)
          .ignoresSafeArea()
        
        ScrollView {
          VStack(spacing: 20) {
            WiFiStatusCard(viewModel: viewModel)
            
            if !viewModel.networks.isEmpty {
              WiFiNetworksCard(viewModel: viewModel)
            }
            
            if viewModel.networks.isEmpty && !viewModel.isScanning {
              WiFiEmptyStateView()
            }
          }
          .padding(.horizontal)
          .padding(.top)
          .padding(.bottom, 100)
        }
      }
      .navigationTitle("WiFi Scanner")
      .overlay(alignment: .bottom) {
        WiFiScanButton(viewModel: viewModel)
      }
    }
    .task {
      await viewModel.refreshStatus()
    }
  }
}
