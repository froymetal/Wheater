//
//  WeatherResponseModel.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import Foundation

struct WeatherResponse: Codable {
    let current: CurrentWeather
    let location: Location
}

struct CurrentWeather: Codable {
    let temp_c: Double // Temperature in Celsius
    let temp_f: Double // Temperature in Farenheih
    let condition: WeatherCondition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
    let feelslike_f: Double

    struct WeatherCondition: Codable {
        let text: String // Weather condition description
        let icon: String // URL for the icon
    }
}

struct Location: Codable {
    let name: String
    let country: String
    let localtime: String
}

struct CitySuggestion: Identifiable {
    let id = UUID()
    let name: String
}
