//
//  MapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
//

import SwiftUI
import MapKit

struct Place : Identifiable {
    var id: UUID = UUID()
    var location: CLLocationCoordinate2D
    var color: Color
}
 
struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.88371, longitude: 127.73947),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )
    @State private var places = [
        Place(
            location: CLLocationCoordinate2D(latitude: 37.88371, longitude: 127.73947),
            color: Color.red
        )
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                Map(coordinateRegion: $region, annotationItems: places) { item in
                    MapMarker(coordinate: item.location, tint: item.color)
                }
                .frame(height: 500)
                .edgesIgnoringSafeArea(.top)
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white.opacity(0.2))
                    })
                }
                .padding(.all, 20)
            }
            
            VStack(alignment: .leading) {
                Text("Nation Name")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("Location Date")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 4)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}
