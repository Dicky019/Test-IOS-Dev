//
//  StatusBadge.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct StatusBadge: View {
  let text: String
  let color: Color
  
  var body: some View {
    Text(text)
      .font(.caption)
      .fontWeight(.medium)
      .padding(.horizontal, 10)
      .padding(.vertical, 4)
      .background(color.opacity(0.2))
      .foregroundColor(color)
      .cornerRadius(8)
  }
}
