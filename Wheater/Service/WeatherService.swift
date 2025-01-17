//
//  WeatherService.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import Foundation
import Combine

class WeatherService {
    func fetchCurrentWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        let urlString = "\(WeatherConstants.baseURL)/current.json?key=\(WeatherConstants.apiKey)&q=\(city)"
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Para actualizar la UI en el hilo principal
            .eraseToAnyPublisher()
    }
}
