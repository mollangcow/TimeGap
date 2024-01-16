//
//  LocalSelectView.swift
//  Pluminus
//
//  Created by kimsangwoo on 12/22/23.
//

import SwiftUI

struct CityListView: View {
    @State private var cityData: [(String, String, String)] = []
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(cityData, id: \.0) { city, flagImageURL, countryName in
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)

                    }, label: {
                        HStack {
                            AsyncImageView(urlString: flagImageURL)
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fit)
                                .padding(.leading, 20)
                            
                            VStack(alignment: .leading) {
                                Text(countryName)
                                    .foregroundStyle(Color.primary)
                                Text("수도 : \(city)")
                                    .font(.caption)
                                    .foregroundStyle(Color.secondary)
                            }
                            .padding(.leading, 12)
                        }
                        .frame(width: screenWidth * 0.88, height: 60, alignment: .leading)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    })
                }
            }
        }
        .onAppear(perform: {
            fetchCityData()
        })
    }
    
    func fetchCityData() {
        let apiUrl = "https://restcountries.com/v3.1/all"
        
        guard let url = URL(string: apiUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let countriesData = try decoder.decode([CountryInfo].self, from: data)
                    
                    var cityFlagData: [(String, String, String)] = []
                    for country in countriesData {
                        if let firstCapital = country.capital?.first, let flag = country.flags?.png, let countryName = country.translations?.kor?.common {
                            let capitalString = String(firstCapital)
                            cityFlagData.append((capitalString, flag, countryName))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cityData = cityFlagData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()
    }
}

struct AsyncImageView: View {
    @State private var imageData: Data?
    let urlString: String
    
    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay() {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 0.5)
                        .foregroundStyle(.gray)
                }
        } else {
            ProgressView() // Show a loading indicator while fetching image
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    private func fetchImage() {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }
        task.resume()
    }
}

struct LocalSelectView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Text("국가 목록")
                        .font(.system(size: 17, weight: .bold))
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            HapticManager.instance.impact(style: .light)
                            dismiss()
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.clear)
                                
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(.primary.opacity(0.2))
                            }
                        })
                    }
                }
                .padding(.top, 4)
                
                CityListView()
            }
        }
    }
}

struct CountryInfo: Decodable {
    struct TransInfo: Decodable {
        struct CommonInfo: Decodable {
            let common: String?
        }
        let kor: CommonInfo?
    }

    let translations: TransInfo?
    let capital: [String]?
    let flags: Flags?
}

struct Flags: Decodable {
    let png: String?
}
