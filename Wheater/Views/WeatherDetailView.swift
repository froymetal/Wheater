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
