//
//  TestIOSDevApp.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

@main
struct TestIOSDevApp: App {
  var isWiFiTarget: Bool {
    Bundle.main.bundleIdentifier?.lowercased().contains("wifi") == true
  }
  var body: some Scene {
    WindowGroup {
      if isWiFiTarget {
        WiFiView()
      } else {
        BluetoothView()
      }
    }
  }
}
