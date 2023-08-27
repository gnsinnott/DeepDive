//
//  DiveLocationEntry.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 8/22/23.
//

import SwiftUI
import SwiftData
import MapKit

struct DiveLocationEntry: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Dive.date)]) var dives: [Dive]
    
    @State private var position: MapCameraPosition = .automatic
    
    @State private var visibleRegion =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @State private var camera: MapCamera?
    
    var name: String
    @Binding public var longitude: Double
    @Binding public var latitude: Double
    
    var body: some View {
        Text(name).font(.largeTitle)
        ZStack{
            Map(position: $position){
                ForEach(dives) { dive in
                    Annotation(dive.name, coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude)){
                        NavigationLink(destination: DiveView(dive: dive)){
                            Image(systemName: "flag.slash.fill")
                                .symbolEffect(.scale)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .red)
                                .tint(.gray)
                        }
                    }
                }
            }
                .onMapCameraChange(frequency: .continuous) { context in
                    visibleRegion = context.region
                    latitude = visibleRegion.center.latitude
                    longitude = visibleRegion.center.longitude
                }
            Image(systemName: "flag.slash.fill")
                .symbolEffect(.scale)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
                .scaleEffect(CGSize(width: 2.0, height: 2.0))
        }
        .frame(height: 300)
        .padding()
        HStack {
            VStack(spacing: 0){
                Text("Latitude")
                    .multilineTextAlignment(.center)
                TextField("Latitude", value: $latitude, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .multilineTextAlignment(.center)
                    .border(.teal)
                    .padding()
                    .onSubmit {
                        position = MapCameraPosition.region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: latitude,
                                longitude: longitude),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.5,
                                longitudeDelta: 0.5)))
                    }
            }
            VStack(spacing: 0){
                Text("Longitude")
                    .multilineTextAlignment(.center)
                TextField("Longitude", value: $longitude, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .multilineTextAlignment(.center)
                    .border(.teal)
                    .padding()
                    .onSubmit {
                        position = MapCameraPosition.region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: latitude,
                                longitude: longitude),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.5,
                                longitudeDelta: 0.5)))
                    }
            }
        }
        Button("Set Location", action: {
            dismiss()
        })
    }
}
