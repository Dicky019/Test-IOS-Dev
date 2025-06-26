//
//  WiFiScanningProgress.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiScanningProgress: View {
  var body: some View {
    HStack {
      ProgressView()
        .scaleEffect(0.8)
      Text("Scanning for networks...")
        .font(.subheadline)
        .foregroundColor(.blue)
    }
    .padding(.top, 8)
  }
}
