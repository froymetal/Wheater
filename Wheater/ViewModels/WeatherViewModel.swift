//
//  WeatherViewModel.swift
//  Wheater
//
//  Created by Froy on 1/17/25.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var citySearchQuery: String = ""
    @Published var citySuggestions: [CitySuggestion] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let service: WeatherService

    init(service: WeatherService = WeatherService()) {
        self.service = service
    }

    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil

        service.fetchCurrentWeather(for: city)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { weatherResponse in
                self.weather = weatherResponse
            })
            .store(in: &cancellables)
    }

    func updateCitySuggestions() {
        // Simulando una lista de ciudades para la demo
        let allCities = ["New York", "Los Angeles", "Houston", "Chicago", "San Francisco", "Miami"]
        citySuggestions = allCities
            .filter { $0.lowercased().contains(citySearchQuery.lowercased()) }
            .map { CitySuggestion(name: $0) }
    }
}
