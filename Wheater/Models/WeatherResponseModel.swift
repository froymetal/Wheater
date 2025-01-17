//
//  WeatherResponseModel.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import Foundation

struct WeatherResponse: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
//    let name: String
    let temp_c: Double // Temperature in Celsius
//    let temp_f: Double // Temperature in Farenheih
    let condition: WeatherCondition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double

    struct WeatherCondition: Codable {
        let text: String // Weather condition description
        let icon: String // URL for the icon
    }
}
