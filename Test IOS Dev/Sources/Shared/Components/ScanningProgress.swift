//
//  ScanningProgress.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct ScanningProgress: View {
  var scaningType: String
  
  var body: some View {
    HStack {
      ProgressView()
        .scaleEffect(0.8)
      Text("Scanning \(scaningType)...")
        .font(.subheadline)
        .foregroundColor(.blue)
    }
    .padding(.top, 8)
  }
}
