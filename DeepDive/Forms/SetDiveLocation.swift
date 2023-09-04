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
    @State public var locationSet = false
    
    @Binding public var location: String
    @Binding public var boat: Bool
    @Binding public var saltWater: Bool
    
    @Binding public var waterTemp: Double
    @Binding public var airTemp: Double
    @Binding public var tempUnit: Bool
    
    @State private var showingSheet = false
    
    var body: some View {
        Form {
            Text(name).font(.largeTitle)
            Section(header: Text("Dive Location")) {
                Button("\(locationSet ? "Change Dive Location" : "Select Dive Location")") {
                    locationSet = true
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet){
                    DiveLocationEntry(name: name, longitude: $longitude, latitude: $latitude)
                }
                Text("\(String(format: "%.6f", latitude))˚\(latitude >= 0 ? "N" : "S"), \(String(format: "%.6f", longitude))˚\(longitude >= 0 ? "E" : "W")")
            }
            Section(header: Text("Location Details")) {
                HStack{
                    Text("Location Name:")
                        .foregroundStyle(.secondary)
                    TextField("location", text: $location)
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
                            TextField("0", value: $airTemp, formatter: Formatter.blankZeroFormat)
                                .keyboardType(.decimalPad)
                        }
                        HStack{
                            Text("Water")
                                .foregroundStyle(.secondary)
                            TextField("0", value: $waterTemp, formatter: Formatter.blankZeroFormat)
                                .keyboardType(.decimalPad)
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

