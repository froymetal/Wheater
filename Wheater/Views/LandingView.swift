//
//  LandingView.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import SwiftUI

struct LandingView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2.0)
            } else if viewModel.weather != nil {
                WeatherView(viewModel: viewModel)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.fetchWeather(for: "Houston")
        }
    }
}



