//
//  SignalStrengthIndicator.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SwiftUI

struct SignalStrengthIndicator: View {
  let signalStrength: Int
  
  var body: some View {
    HStack(spacing: 2) {
      ForEach(1...4, id: \.self) { bar in
        RoundedRectangle(cornerRadius: 2)
          .fill(bar <= bars ? iconColor : Color.gray.opacity(0.3))
          .frame(width: 3, height: CGFloat(bar * 3 + 4))
      }
    }
  }
  
  private var bars: Int {
    let strength = abs(signalStrength)
    if strength < 50 {
      return 4
    } else if strength < 70 {
      return 3
    } else if strength < 85 {
      return 2
    } else {
      return 1
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
