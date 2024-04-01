//
//  testView.swift
//  Pluminus
//
//  Created by kimsangwoo on 3/30/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var cityName: String = ""
    @State private var localTime: String = "시간을 불러오는 중..."

    var body: some View {
        VStack {
            TextField("도시 이름을 입력하세요", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("시간 확인") {
                getLocalTime(cityName: cityName) { time in
                    self.localTime = time
                }
            }

            Text(localTime)
                .padding()
        }
        .padding()
    }

    func getLocalTime(cityName: String, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            guard error == nil else {
                completion("위치를 찾을 수 없습니다.")
                return
            }
            
            if let placemark = placemarks?.first, let timezone = placemark.timeZone {
                let formatter = DateFormatter()
                formatter.timeZone = timezone
                formatter.dateStyle = .long
                formatter.timeStyle = .long
                
                completion(formatter.string(from: Date()))
            } else {
                completion("시간을 불러올 수 없습니다.")
            }
        }
    }
}
