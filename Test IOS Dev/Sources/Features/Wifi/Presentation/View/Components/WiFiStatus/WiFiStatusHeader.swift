//
//  WiFiStatusHeader.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//


import SwiftUI

struct WiFiStatusHeader: View {
  let networkStatus: NetworkStatus
  
  var body: some View {
    HStack {
      Image(systemName: "wifi")
        .font(.title2)
        .foregroundColor(.blue)
      
      Text("WiFi Status")
        .font(.title2)
        .fontWeight(.semibold)
      
      Spacer()
      
      StatusBadge(
        text: networkStatus.displayText,
        color: networkStatus == .connected(type: .wifi) ? .green : .orange
      )
    }
  }
}
