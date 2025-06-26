//
//  WiFiEmptyStateView.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiEmptyStateView: View {
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "wifi.slash")
        .font(.system(size: 50))
        .foregroundColor(.gray)
      
      Text("No networks found")
        .font(.headline)
        .foregroundColor(.gray)
      
      Text("Tap 'Scan for Networks' to search for nearby WiFi networks")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
    .padding(.top, 40)
  }
}
