//import SwiftUI
//import Foundation
//import Combine
//
//import Foundation
//
//struct WeatherResponse: Codable {
//    let current: CurrentWeather
//    let location: Location
//}
//
//struct CurrentWeather: Codable {
//    let temp_c: Double // Temperature in Celsius
//    let temp_f: Double // Temperature in Farenheih
//    let condition: WeatherCondition
//    let humidity: Int
//    let uv: Double
//    let feelslike_c: Double
//    let feelslike_f: Double
//
//    struct WeatherCondition: Codable {
//        let text: String // Weather condition description
//        let icon: String // URL for the icon
//    }
//}
//
//struct Location: Codable {
//    let name: String
//    let country: String
//    let localtime: String
//}
//
//class WeatherConstants {
//    static let apiKey = a"026338f128b84607ad105550251701"
//    static let baseURL = "https://api.weatherapi.com/v1"
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
//class WeatherViewModel: ObservableObject {
//    @Published var weather: WeatherResponse?
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
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
//            // Weather Icon
//            VStack(alignment: .center) {
//                AsyncImage(url: URL(string: "https:\(viewModel.weather?.current.condition.icon ?? "")")) { image in
//                    image.resizable().scaledToFit().frame(width: 123, height: 123)
//                } placeholder: {
//                    ProgressView()
//                }
//                // City Name and Temperature
//                HStack(spacing: 11) {
//                    Text("\(viewModel.weather?.location.name ?? "No city")")
//                        .font(.title)
//                        .font(.system(size: 30))
//                        .fontWeight(.bold)
//                    Image("Arrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 21, height: 21)
//                }
//                HStack(alignment: .top) {
//                    Text("\(viewModel.weather?.current.temp_f ?? 0, specifier: "%.0f")")
////                    Text("31")
//                        .font(.system(size: 70))
//                        .fontWeight(.bold)
//                    Image("Degrees")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 8, height: 8)
//                }
//            }.padding(.bottom, 35)
//            
//            // Weather Details Bottom
//            HStack {
//                WeatherDetailView(title: "Humidity", value: "\(viewModel.weather?.current.humidity ?? 0)%")
//                WeatherDetailView(title: "UV", value: "\(viewModel.weather?.current.uv ?? 0)")
//                WeatherDetailView(title: "Feels Like", value: "\(viewModel.weather?.current.feelslike_f ?? 0)")
//            }
//            .frame(height: 75)
//            .background(Color(.systemGray5))
//            .cornerRadius(20)
//            .padding(.horizontal, 56)
//        }
//        Spacer()
//    }
//    
//    @ViewBuilder
//    func searchBar() -> some View {
//        HStack {
//            TextField("Search Location", text: .constant(""))
//                .padding(.leading, 30)
//                .frame(height: 46)
//                .background(Color(.systemGray5))
//                .cornerRadius(10)
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
//struct WeatherDetailView: View {
//    var title: String
//    var value: String
//
//    var body: some View {
//        VStack {
//            Text(title)
//                .font(.system(size: 12))
//                .foregroundColor(Color(hex: "C4C4C4"))
//            Text(value)
//                .font(.system(size: 15))
//                .foregroundColor(Color(hex: "9A9A9A"))
//        }
//        .frame(maxWidth: .infinity)
//    }
//}
