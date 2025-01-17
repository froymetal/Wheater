//
//  LandingView.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import SwiftUI

struct LandingView: View {
//    @StateObject private var viewModel: WeatherViewModel
    @ObservedObject var viewModel: WeatherViewModel

//    init() {
//        _viewModel = StateObject(wrappedValue: WeatherViewModel())
        init(viewModel: WeatherViewModel) {
                self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2.0)
            } else if let weather = viewModel.weather {
                WeatherView(viewModel: viewModel)
//                VStack(spacing: 20) {
//                    Text("\(weather.current.temp_c, specifier: "%.1f")°C")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                    Text(weather.current.condition.text)
//                        .font(.headline)
//
//                    AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
//                        image.resizable().scaledToFit().frame(width: 100, height: 100)
//                    } placeholder: {
//                        ProgressView()
//                    }
//
//                    HStack {
//                        WeatherDetailView1(type: "Humidity", value: "\(weather.current.humidity)%")
//                        WeatherDetailView1(type: "UV Index", value: "\(weather.current.uv)")
//                        WeatherDetailView1(type: "Feels Like", value: "\(weather.current.feelslike_c)°C")
//                    }
//                }
//                .padding()
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


//struct WeatherDetailView1: View {
//    let type: String
//    let value: String
//
//    var body: some View {
//        VStack {
//            Text(type)
//                .font(.caption)
//                .foregroundColor(.gray)
//            Text(value)
//                .font(.headline)
//                .fontWeight(.bold)
//        }
//        .frame(maxWidth: .infinity)
//    }
//}



