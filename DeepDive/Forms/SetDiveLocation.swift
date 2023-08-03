//
//  DiveMapView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/22/23.
//

import SwiftUI
import MapKit
import SwiftData

struct SetDiveLocationView: View {
    var name: String = ""
    
    @Binding public var longitude: Double
    @Binding public var latitude: Double
    @State private var pinDropped: Bool = false
    
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var diveSite = Marker("Dive Name", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 10))
    
    
    @Binding public var location: String
    @Binding public var boat: Bool
    @Binding public var saltWater: Bool
    
    @FocusState private var focusedField: String?
    
    @Binding public var waterTemp: Double
    @Binding public var airTemp: Double
    @Binding public var tempUnit: Bool
    
    var body: some View {
        @State var newDiveSite = Marker(name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        Form {
            Text(name).font(.largeTitle)
            Section(header: Text("Dive Location")) {
                ZStack {
                    Map(position: $position){
                        if pinDropped{
                            diveSite
                                .stroke(lineWidth: 30)
                        }
                    }
                    .onMapCameraChange { context in
                        visibleRegion = context.region
                    }
                    Image(systemName: "mappin").imageScale(.large)
                }.frame(height: 300)
                HStack {
                    Button("Drop Pin") {
                        latitude = visibleRegion?.center.latitude ?? 0.0
                        longitude = visibleRegion?.center.longitude ?? 0.0
                        diveSite = Marker(name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                        print(latitude, longitude)
                        pinDropped = true
                    }
                    Text("or set manually below")
                }
                HStack{
                    VStack{
                        HStack {
                            Text("Latitude")
                                .foregroundStyle(.secondary)
                            TextField("Latitude:", value:$latitude, format: .number)
                                .focused($focusedField, equals: "latitude")
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: latitude) {oldValue, newValue in
                                    if (newValue > 180 || newValue < -180) {
                                        latitude = oldValue
                                    }
                                }
                        }
                        HStack {
                            Text("Longitude")
                                .foregroundStyle(.secondary)
                            TextField("Longitude:", value:$longitude, format: .number)
                                .focused($focusedField, equals: "longitude")
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: longitude) {oldValue, newValue in
                                    if (newValue > 180 || newValue < -180) {
                                        longitude = oldValue
                                    }
                                }
                        }
                    }
                    Button("Set") {
                        newDiveSite = Marker(name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                        diveSite = newDiveSite
                        print(latitude, longitude)
                        pinDropped = true
                    }
                }
                
                Text("Dive Coordinates: \(latitude, specifier: "%.5f"), \(longitude, specifier: "%.5f")")
            }
            Section(header: Text("Location Details")) {
                HStack{
                    Text("Location Name:")
                        .foregroundStyle(.secondary)
                    TextField("Location Name", text: $location)
                }
                
                Toggle(boat ? "Boat Dive 🛥️" : "Shore Dive 🏝️", isOn: $boat)
                    .tint(Color.blue)
                Toggle(saltWater ? "Salt Water" : "Fresh Water", isOn: $saltWater)
                    .tint(Color.blue)
            }
            Section(header: Text("Temperature")) {
                HStack{
                    VStack{
                        HStack{
                            Text("Air")
                                .foregroundStyle(.secondary)
                            TextField("Enter air temperature", value: $airTemp, format: .number).keyboardType(.decimalPad)
                        }
                        HStack{
                            Text("Water")
                                .foregroundStyle(.secondary)
                            TextField("Enter water temperature", value: $waterTemp, format: .number).keyboardType(.decimalPad)
                        }
                    }
                    Picker("", selection: $tempUnit) {
                        Text("Celcius").tag(true)
                        Text("Farenheit").tag(false)
                    }
                }
            }
        }
    }
}
