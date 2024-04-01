//
//  LocalSelectView.swift
//  Pluminus
//
//  Created by kimsangwoo on 12/22/23.
//

import CoreLocation
import SwiftUI

struct LocaleSelectView: View {
    @ObservedObject var viewModel = CountriesViewModel()
    
    @State private var searchText = ""
    
    @Binding var isShowingLocal : Bool
    @Binding var selectedLocationName : String
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredCountries, id: \.self) { country in
                        NavigationLink(destination: LocaleSelectCityView(isShowingLocal: $isShowingLocal, selectedLocationName: $selectedLocationName, cities: country.cities, countryName: country.country)) {
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
