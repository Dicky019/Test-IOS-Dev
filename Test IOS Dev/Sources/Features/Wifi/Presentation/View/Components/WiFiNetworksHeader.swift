//
//  WiFiNetworksHeader.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworksHeader: View {
  let count: Int
  
  var body: some View {
    HStack {
      Text("Available Networks")
        .font(.headline)
        .fontWeight(.semibold)
      
      Spacer()
      
      NetworkCountBadge(count: count)
    }
  }
}
