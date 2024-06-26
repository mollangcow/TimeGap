//
//  CLMapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 6/26/24.
//

import SwiftUI
import MapKit
import Foundation
import CoreLocation


extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Published var locationName: String = "Unknown Location"
    private var hasSetInitialLocation = false
    private var geocodeRequestTimer: Timer?
    private var debounceInterval: TimeInterval = 0.5 // Adjust debounce interval as needed
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if !hasSetInitialLocation {
            region.center = location.coordinate
            updateLocationName(for: location.coordinate)
            hasSetInitialLocation = true
        }
    }
    
    func updateCenterCoordinate(_ coordinate: CLLocationCoordinate2D) {
        region.center = coordinate
        debounceUpdateLocationName(for: coordinate)
    }
    
    private func debounceUpdateLocationName(for coordinate: CLLocationCoordinate2D) {
        geocodeRequestTimer?.invalidate()
        geocodeRequestTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            self?.updateLocationName(for: coordinate)
        }
    }
    
    private func updateLocationName(for coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first, error == nil {
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                self.locationName = city.isEmpty || country.isEmpty ? "Unknown Location" : "\(city), \(country)"
            } else {
                self.locationName = "Unknown Location"
            }
        }
    }
    
    func isLocationValid() -> Bool {
        return locationName != "Unknown Location" && !locationName.contains("Unknown")
    }
}


struct CLMapView: View {
    @StateObject private var locationManager = LocationManager()
    @Binding var isShowingCLMapView : Bool
    @Binding var savedLocation: CLLocationCoordinate2D?
    var onSave: ((String) -> Void)? // Callback closure for passing location name
        
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .ignoresSafeArea(edges: .all)
                .onAppear {
                    Pluminus.locationManager.locationManager.requestWhenInUseAuthorization()
                }
                .onChange(of: locationManager.region.center) { newCenter in
                    locationManager.updateCenterCoordinate(newCenter)
                }
            
            // Center pin
            Image(systemName: "mappin.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .offset(x: 0, y: -20)
            
            VStack {
                Spacer()
                Text(locationManager.locationName)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Save current location
                        savedLocation = locationManager.region.center
                        onSave?(locationManager.locationName) // 위치 이름과 시간대 오프셋을 전달
                    }) {
                        Text("Save")
                            .font(.title2)
                            .padding()
                            .background(locationManager.isLocationValid() ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding()
                    .disabled(!locationManager.isLocationValid())
                }
            }
        }
    }
}
