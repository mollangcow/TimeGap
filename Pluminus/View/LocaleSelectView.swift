//
//  LocalSelectView.swift
//  Pluminus
//
//  Created by kimsangwoo on 12/22/23.
//

import SwiftUI

struct LocaleSelectView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = CountriesViewModel()
    @State private var searchText = ""
    @Binding var isShowingLocal : Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredCountries, id: \.self) { country in
                        NavigationLink(destination: CityListView(isShowingLocal: $isShowingLocal, cities: country.cities, countryName: country.country)) {
                            HStack {
                                Text(country.country)
                                    .lineLimit(1)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.primary)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.orange)
                                    .bold()
                                    .padding(.trailing, 20)
                            }
                            .frame(height: 60, alignment: .leading)
                            .background(.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .navigationTitle("국가")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        HapticManager.instance.impact(style: .light)
                        dismiss()
                    } label: {
                        ZStack(alignment: .trailing) {
                            Rectangle()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.clear)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }

                }
            }
            .onAppear {
                viewModel.fetchCountries()
            }
        }
        .accentColor(.orange)
    }

    var filteredCountries: [CountryModel] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { country in
                country.country.localizedCaseInsensitiveContains(searchText) ||
                country.cities.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }
}


struct CityListView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @Binding var isShowingLocal : Bool
    var cities: [String]
    var countryName: String // 도시 목록이 비어있을 때 국가 이름을 표시하기 위한 프로퍼티
    
    var body: some View {
        ScrollView {
            if cities.isEmpty {
                // 도시 목록이 비어있을 때 처리할 내용
                VStack {
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)
                        isShowingLocal = false
                        print("City Select : \(countryName)")
                    }) {
                        HStack {
                            Text(countryName)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color.primary)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .frame(height: 60, alignment: .leading)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                    }
                    
                    Text("\(countryName)에는 선택 가능한 도시 목록이 없습니다.")
                        .padding(.top, 12)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            } else {
                // 도시 목록이 비어있지 않을 때 도시를 출력
                LazyVStack {
                    ForEach(filteredCities, id: \.self) { city in
                        Button(action: {
                            HapticManager.instance.impact(style: .rigid)
                            isShowingLocal = false
                            print("City Select : \(city)")
                        }) {
                            HStack {
                                Text(city)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.primary)
                                    .padding(.leading, 20)
                                
                                Spacer()
                            }
                            .frame(height: 60, alignment: .leading)
                            .background(.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
        .navigationTitle("\(countryName)의 도시")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
    }

    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}


class CountriesViewModel: ObservableObject {
    @Published var countries = [CountryModel]()

    func fetchCountries() {
        guard let url = URL(string: "https://countriesnow.space/api/v0.1/countries") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(CountriesData.self, from: data) {
                    DispatchQueue.main.async {
                        self.countries = decodedResponse.data
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct CountryModel: Codable, Identifiable, Hashable {
    let id = UUID()
    var country: String
    var cities: [String]
}

struct CountriesData: Codable {
    var data: [CountryModel]
}
