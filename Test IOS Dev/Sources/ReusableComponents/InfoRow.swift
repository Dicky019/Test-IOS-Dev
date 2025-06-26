//
//  InfoRow.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct InfoRow: View {
  let label: String
  let value: String
  
  var body: some View {
    HStack {
      Text(label)
        .font(.subheadline)
        .foregroundColor(.secondary)
      
      Spacer()
      
      Text(value)
        .font(.subheadline)
        .fontWeight(.medium)
    }
  }
}
