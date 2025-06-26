//
//  NetworkCountBadge.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct NetworkCountBadge: View {
  let count: Int
  
  var body: some View {
    Text("\(count)")
      .font(.caption)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(Color.blue.opacity(0.2))
      .foregroundColor(.blue)
      .cornerRadius(8)
  }
}
