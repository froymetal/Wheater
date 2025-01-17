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
            
            // Weather Icon
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: "https:\(viewModel.weather?.current.condition.icon ?? "")")) { image in
                    image.resizable().scaledToFit().frame(width: 123, height: 123)
                } placeholder: {
                    ProgressView()
                }
                // City Name and Temperature
                HStack(spacing: 11) {
                    Text("\(viewModel.weather?.location.name ?? "No city")")
                        .font(.title)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Image("Arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21, height: 21)
                }
                HStack(alignment: .top) {
                    Text("\(viewModel.weather?.current.temp_f ?? 0, specifier: "%.0f")")
//                    Text("31")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                    Image("Degrees")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 8, height: 8)
                }
            }.padding(.bottom, 35)
            
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
    
    @ViewBuilder
    func searchBar() -> some View {
        HStack {
            TextField("Search Location", text: .constant(""))
                .padding(.leading, 30)
                .frame(height: 46)
                .background(Color(.systemGray5))
                .cornerRadius(10)
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

