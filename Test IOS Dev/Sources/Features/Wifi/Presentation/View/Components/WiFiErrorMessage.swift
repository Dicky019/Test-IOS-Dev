//
//  WiFiErrorMessage.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiErrorMessage: View {
  let message: String
  
  var body: some View {
    HStack {
      Image(systemName: "exclamationmark.triangle.fill")
        .foregroundColor(.orange)
      Text(message)
        .font(.caption)
        .foregroundColor(.orange)
    }
    .padding(.top, 4)
  }
}
