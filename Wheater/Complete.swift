//import SwiftUI
//import Foundation
//import Combine
//
//struct LandingView: View {
//    @ObservedObject var viewModel: WeatherViewModel
//    
//    init(viewModel: WeatherViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        VStack {
//            if viewModel.isLoading {
//                ProgressView()
//                    .scaleEffect(2.0)
//            } else if viewModel.weather != nil {
//                WeatherView(viewModel: viewModel)
//            } else if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//            } else {
//                VStack(alignment: .center, spacing: 20){
//                    Text("No City selected")
//                        .font(.system(size: 30))
//                        .fontWeight(.bold)
//                    Text("Please Search For A City")
//                        .font(.system(size: 15))
//                        .fontWeight(.bold)
//                }
//            }
//        }
//        .onAppear {
//            viewModel.fetchWeather(for: "Houston")
//        }
//    }
//}
//
//struct WeatherView: View {
//    @ObservedObject var viewModel: WeatherViewModel
//    
//    init(viewModel: WeatherViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            // Search Bar
//            searchBar()
//                .padding(.top, 44)
//                .padding(.horizontal, 24)
//                .padding(.bottom,80)
//            
//            // City Suggestions
//            if !viewModel.citySuggestions.isEmpty {
//                List(viewModel.citySuggestions) { suggestion in
//                    Button(action: {
//                        viewModel.fetchWeather(for: suggestion.name)
//                        viewModel.citySearchQuery = suggestion.name
//                        viewModel.citySuggestions = []
//                    }) {
//                        Text(suggestion.name)
//                            .foregroundColor(.primary)
//                    }
//                }
//                .frame(maxHeight: 200)
//            }
//            
//            // Weather Icon and Details
//            if let weather = viewModel.weather {
//                VStack(alignment: .center) {
//                    // Weather Icon
//                    AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
//                        image.resizable().scaledToFit().frame(width: 123, height: 123)
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    // City Name and Temperature
//                    HStack(spacing: 11) {
//                        Text(weather.location.name)
//                            .font(.system(size: 30))
//                            .fontWeight(.bold)
//                        Image("Arrow")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 21, height: 21)
//                    }
//                    HStack(alignment: .top) {
//                        Text("\(weather.current.temp_f, specifier: "%.0f")")
//                            .font(.system(size: 70))
//                            .fontWeight(.bold)
//                        Image("Degrees")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 8, height: 8)
//                    }
//                }
//                .padding(.bottom, 35)
//                
//                // Weather Details Bottom
//                HStack {
//                    WeatherDetailView(title: "Humidity", value: "\(viewModel.weather?.current.humidity ?? 0)%")
//                    WeatherDetailView(title: "UV", value: "\(viewModel.weather?.current.uv ?? 0)")
//                    WeatherDetailView(title: "Feels Like", value: "\(viewModel.weather?.current.feelslike_f ?? 0)")
//                }
//                .frame(height: 75)
//                .background(Color(.systemGray5))
//                .cornerRadius(20)
//                .padding(.horizontal, 56)
//            }
//            
//            Spacer()
//        }
//    }
//    
//    @ViewBuilder
//    func searchBar() -> some View {
//        HStack {
//            TextField("Search Location", text: $viewModel.citySearchQuery)
//                .padding(.leading, 30)
//                .frame(height: 46)
//                .background(Color(.systemGray5))
//                .cornerRadius(10)
//                .onChange(of: viewModel.citySearchQuery) { _ in
//                    viewModel.updateCitySuggestions()
//                }
//                .overlay(
//                    HStack {
//                        Spacer()
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .padding(.trailing, 14)
//                    }
//                )
//        }
//    }
//}
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather: WeatherResponse?
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//    @Published var citySearchQuery: String = ""
//    @Published var citySuggestions: [CitySuggestion] = []
//    
//    private var cancellables = Set<AnyCancellable>()
//    private let service: WeatherService
//
//    init(service: WeatherService = WeatherService()) {
//        self.service = service
//    }
//
//    func fetchWeather(for city: String) {
//        isLoading = true
//        errorMessage = nil
//
//        service.fetchCurrentWeather(for: city)
//            .sink(receiveCompletion: { completion in
//                self.isLoading = false
//                switch completion {
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                case .finished:
//                    break
//                }
//            }, receiveValue: { weatherResponse in
//                self.weather = weatherResponse
//            })
//            .store(in: &cancellables)
//    }
//
//    func updateCitySuggestions() {
//        // Simulando una lista de ciudades para la demo
//        let allCities = ["New York", "Los Angeles", "Houston", "Chicago", "San Francisco", "Miami"]
//        citySuggestions = allCities
//            .filter { $0.lowercased().contains(citySearchQuery.lowercased()) }
//            .map { CitySuggestion(name: $0) }
//    }
//}
//
//class WeatherService {
//    func fetchCurrentWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
//        let urlString = "\(WeatherConstants.baseURL)/current.json?key=\(WeatherConstants.apiKey)&q=\(city)"
//        guard let url = URL(string: urlString) else {
//            return Fail(error: NSError(domain: "Invalid URL", code: 400, userInfo: nil))
//                .eraseToAnyPublisher()
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main) // Para actualizar la UI en el hilo principal
//            .eraseToAnyPublisher()
//    }
//}
//
//
//class WeatherConstants {
//    static let apiKey = "026338f128b84607ad105550251701"
//    static let baseURL = "https://api.weatherapi.com/v1"
//}
//
//
