//
//  InfoHeader.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct InfoHeader: View {
  let count: Int
  
  var body: some View {
    HStack {
      Text("Available Networks")
        .font(.headline)
        .fontWeight(.semibold)
      
      Spacer()
      
      CountBadge(count: count)
    }
  }
}
