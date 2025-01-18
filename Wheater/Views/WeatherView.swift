//
//  WeatherView.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Search Bar
            searchBar()
                .padding(.top, 44)
                .padding(.horizontal, 24)
                .padding(.bottom,80)
            
            // City Suggestions
            if !viewModel.citySuggestions.isEmpty {
                List(viewModel.citySuggestions) { suggestion in
                    Button(action: {
                        viewModel.fetchWeather(for: suggestion.name)
                        viewModel.citySearchQuery = suggestion.name
                        viewModel.citySuggestions = []
                    }) {
                        Text(suggestion.name)
                            .foregroundColor(.primary)
                    }
                }
                .frame(maxHeight: 200)
            }
            
            // Weather Icon and Details
            if let weather = viewModel.weather {
                VStack(alignment: .center) {
                    // Weather Icon
                    AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                        image.resizable().scaledToFit().frame(width: 123, height: 123)
                    } placeholder: {
                        ProgressView()
                    }
                    // City Name and Temperature
                    HStack(spacing: 11) {
                        Text(weather.location.name)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Image("Arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21, height: 21)
                    }
                    HStack(alignment: .top) {
                        Text("\(weather.current.temp_f, specifier: "%.0f")")
                            .font(.system(size: 70))
                            .fontWeight(.bold)
                        Image("Degrees")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 35)
                
                // Weather Details Bottom
                HStack {
                    WeatherDetailView(title: "Humidity", value: "\(viewModel.weather?.current.humidity ?? 0)%")
                    WeatherDetailView(title: "UV", value: "\(viewModel.weather?.current.uv ?? 0)")
                    WeatherDetailView(title: "Feels Like", value: "\(viewModel.weather?.current.feelslike_f ?? 0)")
                }
                .frame(height: 75)
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding(.horizontal, 56)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func searchBar() -> some View {
        HStack {
            TextField("Search Location", text: $viewModel.citySearchQuery)
                .padding(.leading, 30)
                .frame(height: 46)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .onChange(of: viewModel.citySearchQuery) { _ in
                    viewModel.updateCitySuggestions()
                }
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 14)
                    }
                )
        }
    }
}
