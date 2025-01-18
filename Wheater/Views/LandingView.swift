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
            } else {
                VStack(alignment: .center, spacing: 20){
                    Text("No City selected")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Text("Please Search For A City")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                }
            }
        }
        .onAppear {
            // Cargar la última ciudad guardada o usar Houston como default
            let savedCity = UserDefaults.standard.string(forKey: "lastSelectedCity") ?? "Houston"
            viewModel.fetchWeather(for: savedCity)
        }
    }
}



