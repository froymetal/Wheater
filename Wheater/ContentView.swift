//
//  TestMainView.swift
//  Wheater
//
//  Created by Froy on 1/16/25.
//

import SwiftUI

struct TestMainView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            // Search Bar
            searchBar()
                .padding(.top, 44)
                .padding(.horizontal, 24)
                .padding(.bottom,80)
            
            // Weather Icon
            VStack {
                ZStack {
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 123, height: 123)
                        .foregroundColor(Color.orange)
                    
                    HStack(spacing: -10) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .offset(x: 40, y: -30)
                }
                // City Name and Temperature
                HStack(spacing: 11) {
                    Text("Hyderabad")
                        .font(.title)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Image("Arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21, height: 21)
                }
                HStack(alignment: .top) {
                    Text("31")
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
                WeatherDetailView(title: "Humidity", value: "20%")
                WeatherDetailView(title: "UV", value: "4")
                WeatherDetailView(title: "Feels Like", value: "38°")
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


#Preview {
    TestMainView()
}

