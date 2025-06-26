//
//  WiFiStatusInfo.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiStatusInfo: View {
  let networkStatus: NetworkStatus
  let locationPermissionStatus: LocationPermissionStatus
  let isScanning: Bool
  let networkCount: Int
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      InfoRow(label: "Connection", value: networkStatus.displayText)
      InfoRow(label: "Location Permission", value: locationPermissionStatus.rawValue)
      InfoRow(label: "Scanning", value: isScanning ? "Active" : "Inactive")
      InfoRow(label: "Networks Found", value: "\(networkCount)")
    }
  }
}
