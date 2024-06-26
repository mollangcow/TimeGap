//
//  MapFocusView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var countryName: String
    @Binding var locality: String
    
    func makeCoordinator() -> MapViewDelegate {
        return MapViewDelegate()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let geocoder = CLGeocoder()
        let country = locality.isEmpty ? countryName : locality
        
        geocoder.geocodeAddressString(country) { placemarks, error in
            if let placemark = placemarks?.first,
               let location = placemark.location {
                let coordinate = location.coordinate
                let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                uiView.setRegion(region, animated: false)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = country
                uiView.addAnnotation(annotation)
            }
        }
    }
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil } // Check if it's an MKPointAnnotation

        let identifier = "CustomAnnotationView"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            if let markerAnnotationView = annotationView as? MKMarkerAnnotationView {
                markerAnnotationView.markerTintColor = .red
                markerAnnotationView.glyphTintColor = .white
            }
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}

