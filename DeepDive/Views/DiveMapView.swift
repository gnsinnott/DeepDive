//
//  DiveMapView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/22/23.
//

import SwiftUI
import MapKit
import SwiftData

struct DiveMapView: View {
    @State private var diveName: String = "Two Crabs"
    @State private var pinLongitude: Double = 0.0
    @State private var pinLatitude: Double = 0.0
    @State private var pinDropped: Bool = false
    @State private var camera: MapCamera = .init(centerCoordinate: CLLocationCoordinate2D(latitude: -57, longitude: 0), distance: 10)
    
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var diveSite = Marker("Dive Name", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 10))
    
    var body: some View {
        
        VStack {
            Text(diveName).font(.largeTitle)
            ZStack {
                Map(position: $position){
                    if pinDropped{
                        diveSite
                            .stroke(lineWidth: 30)
                    }
                    
                }
                    .onMapCameraChange { context in
                        visibleRegion = context.region
                        print(visibleRegion?.center.latitude)
                        print(visibleRegion?.center.longitude)
                    }
                Image(systemName: "mappin").imageScale(.large)

            }
            Button("Set Location") {
                pinLatitude = visibleRegion?.center.latitude ?? 0.0
                pinLongitude = visibleRegion?.center.longitude ?? 0.0
                var newDiveSite = Marker(diveName, coordinate: CLLocationCoordinate2D(latitude: pinLatitude, longitude: pinLongitude))
                diveSite = newDiveSite
                print(pinLatitude, pinLongitude)
                pinDropped = true
            }
            Text("Dive Coordinates: \(pinLatitude), \(pinLongitude)")
        }
        .padding()
    }
}

#Preview {
    DiveMapView()
}
