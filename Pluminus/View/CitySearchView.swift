//
//  CitySearchView.swift
//  Pluminus
//
//  Created by kimsangwoo on 1/22/24.
//

import SwiftUI

struct GeonamesCredentials {
    static let sharedUsername: String? = "mollangcow"
}

struct CitySearchView: View {
    @State private var cityName = ""
    @State private var cities: [City] = []
    
    var body: some View {
        VStack {
            TextField("Enter city name", text: $cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Search") {
                searchCities()
            }
            .padding()
            
            List(cities, id: \.geonameId) { city in
                VStack(alignment: .leading) {
                    Text(city.name)
                        .font(.headline)
                    Text(city.countryName)
                        .font(.subheadline)
                }
            }
            .listStyle(PlainListStyle())
            .padding()
            
            Spacer()
        }
    }
    
    func searchCities() {
        guard let mollangcow = GeonamesCredentials.sharedUsername else {
            print("Geonames username is missing.")
            return
        }
        
        let apiEndpoint = "http://api.geonames.org/searchJSON"
        let queryParams = [
            "q": cityName,
            "username": mollangcow
        ]
        
        NetworkManager.shared.fetchData(endpoint: apiEndpoint, queryParams: queryParams) { (result: Result<GeonamesResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    cities = response.geonames
                }
            case .failure(let error):
                print("Error searching cities: \(error.localizedDescription)")
                
                if let urlError = error as? URLError {
                    print("URL error code: \(urlError.code.rawValue)")
                    print("URL error description: \(urlError.localizedDescription)")
                }
            }
        }
    }
}

// Model for Geonames API response
struct GeonamesResponse: Codable {
    let geonames: [City]
}

// Model for City
struct City: Codable, Identifiable {
    let geonameId: Int
    let name: String
    let countryName: String
    
    var id: Int {
        return geonameId
    }
    
    enum CodingKeys: String, CodingKey {
        case geonameId = "geonameId"
        case name = "name"
        case countryName = "countryName"
    }
}

// Networking manager for making API requests
class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData<T: Codable>(endpoint: String, queryParams: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
