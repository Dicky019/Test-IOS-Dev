//
//  WiFiNetworkIcon.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct WiFiNetworkIcon: View {
    let signalStrength: Int
    let isConnected: Bool
    
    var body: some View {
        Image(systemName: wifiIcon)
            .foregroundColor(isConnected ? .green : iconColor)
            .frame(width: 30)
    }
    
    private var wifiIcon: String {
        let strength = abs(signalStrength)
        if strength < 50 {
            return "wifi"
        } else if strength < 70 {
            return "wifi.exclamationmark"
        } else {
            return "wifi.slash"
        }
    }
    
    private var iconColor: Color {
        let strength = abs(signalStrength)
        if strength < 50 {
            return .blue
        } else if strength < 70 {
            return .orange
        } else {
            return .gray
        }
    }
}
