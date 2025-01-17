//
//  WeatherDetailView.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import SwiftUI

struct WeatherDetailView: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "C4C4C4"))
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "9A9A9A"))
        }
        .frame(maxWidth: .infinity)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RRGGBB
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}
