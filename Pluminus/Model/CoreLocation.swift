//
//  CoreLocation.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import UIKit
import MapKit
import CoreLocation
import Combine

class MyLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var currentTimeHour: String = "--"
    @Published var currentTimeMinut: String = "--"
    @Published var date: Date = Date()
    @Published var currentLocationName: String = "현재 위치 알 수 없음"
    @Published var currentLocationUTC: Int = 0
    
    override init() {
        super.init()

        locationManager.delegate = self

        // 위치 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        // 위치 권한
        locationManager.requestWhenInUseAuthorization()

        // 위치 업데이트
        locationManager.startUpdatingLocation()
        currentLocationName { placemark in
            if let placemark = placemark, let _ = placemark.country, let _ = placemark.locality {
            } else { }
        }
    }

    // 위치 업데이트 발생 시 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let timestamp = location.timestamp

        DispatchQueue.main.async {
            self.date = timestamp

            // 현재 위치의 UTC 정보 받기
            let timeZone = TimeZone.current
            let utcOffsetSeconds = timeZone.secondsFromGMT(for: self.date)
            let utcOffsetHours = utcOffsetSeconds / 3600

            self.currentLocationUTC = utcOffsetHours >= 0 ? utcOffsetHours : -utcOffsetHours
            
            print("ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ")
            print(">>> run : locationManager method")
            print("> Current UTC:", self.currentLocationUTC)
            print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
        }
    }
    
    // 현재 위치의 지역명을 알려주는 메서드
    func currentLocationName(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(lastLocation) { (placemarks, error) in
                if let error = error {
                    print("위치 변환 실패: \(error.localizedDescription)")
                    completionHandler(nil)
                    return
                }
                
                if let placemark = placemarks?.first {
                    self.currentLocationName = "\(placemark.country ?? "") \(placemark.locality ?? "")"
                    completionHandler(placemark)
                } else {
                    print("주소 정보를 찾을 수 없음")
                    completionHandler(nil)
                }
            }
        } else {
            print("위치를 가져올 수 없음")
            completionHandler(nil)
        }
    }
}

let locationManager = MyLocationManager()
