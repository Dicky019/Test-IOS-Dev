//
//  WiFiStatusCard.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//


import SwiftUI

struct WiFiStatusCard: View {
    @ObservedObject var viewModel: WiFiViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            WiFiStatusHeader(networkStatus: viewModel.networkStatus)
            
            // Status Info
            WiFiStatusInfo(
                networkStatus: viewModel.networkStatus,
                locationPermissionStatus: viewModel.locationPermissionStatus,
                isScanning: viewModel.isScanning,
                networkCount: viewModel.networks.count
            )
            
            // Scanning Progress
            if viewModel.isScanning {
                WiFiScanningProgress()
            }
            
            // Error Message
            if let error = viewModel.errorMessage {
                WiFiErrorMessage(message: error)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}