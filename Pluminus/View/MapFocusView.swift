//
//  MapFocusView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
//

import SwiftUI
import MapKit

struct MapFocusView: UIViewRepresentable {
    @Binding var countryName: String
    @Binding var locality: String
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let geocoder = CLGeocoder()
        let countryName = locality == "" ? countryName : locality
        
        geocoder.geocodeAddressString(countryName) { placemarks, error in
            if let placemark = placemarks?.first,
                let location = placemark.location {
                let coordinate = location.coordinate
                let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                uiView.setRegion(region, animated: false)
                print("Latitude: \(location.coordinate.latitude)")
                print("Longitude: \(location.coordinate.longitude)")
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = countryName
                uiView.addAnnotation(annotation)
            }
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
}
