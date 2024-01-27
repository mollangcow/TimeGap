//
//  LocalSelectView.swift
//  Pluminus
//
//  Created by kimsangwoo on 12/22/23.
//

import SwiftUI

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

struct CityListView: View {
    @State private var eachCountryData: [(String, String, String, String)] = []
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(eachCountryData, id: \.0) { countryCapital, countryFlag, countryName, countryCapitalUTC in
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)
                        getCurrentCapitalTime(utc: countryCapitalUTC)
                        print(getCurrentCapitalTime(utc: countryCapitalUTC))
                    }, label: {
                        HStack {
                            CountryFlagImageView(urlString: countryFlag)
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fit)
                                .padding(.leading, 20)
                            
                            VStack(alignment: .leading) {
                                Text(countryName)
                                    .foregroundStyle(Color.primary)
                                Text("수도 : \(countryCapital)")
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
            countryDataAPI()
        })
    }
    
    func countryDataAPI() {
        let apiUrl = "https://restcountries.com/v3.1/all"
        
        guard let url = URL(string: apiUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let allCountryData = try decoder.decode([CountryInfo].self, from: data)
                    
                    var eachCountryData: [(String, String, String, String)] = []
                    
                    for country in allCountryData {
                        if let firstCapital = country.capital?.first,
                           let countryFlag = country.flags?.png,
                           let countryName = country.translations?.kor?.common,
                           let countryCapitalUTC = country.timezones?.first {
                            let countryCapital = String(firstCapital)
                            
                            eachCountryData.append(
                                (
                                    countryCapital,
                                    countryFlag,
                                    countryName,
                                    countryCapitalUTC
                                )
                            )
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.eachCountryData = eachCountryData
                    }
                    
                    print("Country Data API Result: \(eachCountryData)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getCurrentCapitalTime(utc: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // UTC Offset에서 hour과 minute 추출
        let offsetComponents = utc.replacingOccurrences(of: "UTC", with: "").components(separatedBy: ":")
        guard offsetComponents.count == 2,
              let hours = Int(offsetComponents[0]),
              let minutes = Int(offsetComponents[1]) else {
            print("Invalid UTC offset format.")
            return nil
        }
        
        // 현재 날짜 및 시간을 UTC로 생성
        let currentUTCDate = Date()
        
        // 입력된 UTC Offset을 초로 변환
        let totalSeconds = (hours * 60 + minutes) * 60
        // 입력된 UTC Offset을 사용하여 타임 존 생성
        let utcTimeZone = TimeZone(secondsFromGMT: totalSeconds)
        
        // 날짜 포맷터에 UTC 타임 존 설정
        dateFormatter.timeZone = utcTimeZone
        
        // UTC에서 현재 타임 존으로 변환된 날짜를 문자열로 반환
        let localTime = dateFormatter.string(from: currentUTCDate)
        
        return localTime
    }
}

struct CountryFlagImageView: View {
    @State private var imageData: Data?
    let urlString: String
    
    var body: some View {
        if let data = imageData,
           let uiImage = UIImage(data: data) {
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
            ProgressView()
                .onAppear {
                    countryFlagImageAPI()
                }
        }
    }
    
    private func countryFlagImageAPI() {
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

struct CountryInfo: Decodable {
    struct TransInfo: Decodable {
        struct CommonInfo: Decodable {
            let common: String?
        }
        let kor: CommonInfo?
    }
    let capital: [String]?
    let flags: Flags?
    let translations: TransInfo?
    let timezones: [String]?
}

struct Flags: Decodable {
    let png: String?
}
