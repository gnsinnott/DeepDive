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
    @State private var pinLongitude: Double = 0.0
    @State private var pinLatitude: Double = 0.0
    @State private var pinDropped: Bool = false
    @State private var camera: MapCamera = .init(centerCoordinate: CLLocationCoordinate2D(latitude: -57, longitude: 0), distance: 10)
    
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    
    var body: some View {
        VStack {
            Text("Dive Name").font(.largeTitle)
            ZStack {
                Map(position: $position)
                    .onMapCameraChange { context in
                        visibleRegion = context.region
                        print(visibleRegion?.center.latitude)
                        print(visibleRegion?.center.longitude)
                    }
                Image(systemName: "mappin").imageScale(.large)

            }
            Button("Drop Pin") {
                pinLatitude = visibleRegion?.center.latitude ?? 0.0
                pinLongitude = visibleRegion?.center.longitude ?? 0.0
                print(pinLatitude, pinLongitude)
                pinDropped = true
            }
            Text("Dive Coordinates: \(pinLatitude), \(pinLongitude)")
        }
    }
}

#Preview {
    DiveMapView()
}
