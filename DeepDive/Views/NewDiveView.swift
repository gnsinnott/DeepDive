//
//  NewDiveView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/15/23.
//

import SwiftUI
import SwiftData
import MapKit

struct NewDiveView: View {
    
//    var dive: Dive = Dive.emptyDive()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var bottomTime: Int = 0
    @State private var depth: Int = 0
    @State private var depthUnit: Bool = true //true = m, false = ft
    @State private var visibility: Int = 0
    @State private var visibilityUnit: Bool = true //true = m, false = ft
    @State private var diveType: Dive.DiveType = .Deep
    @State private var night: Bool = false
    
    @State private var airMix: Dive.AirMix = .Air
    @State private var startPressure = 0
    @State private var endPressure = 0
    @State private var pressureUnit = true //true = bar, false = psi
    @State private var weight = 0
    @State private var weightUnit = true //true = kg, fales = lbs
    @State private var suit = 0
    
    @State private var boatDive = true
    @State private var saltWater = true
    @State private var airTemp = 0.0
    @State private var waterTemp = 0.0
    @State private var tempUnit = true
    
    
    @State private var location: String = ""
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    
    // TODO: Notes and stamp section
    
    
    var body: some View {
        NavigationStack {
            TabView {
                basicEntryTabView(name: $name, date: $date, bottomTime: $bottomTime, depth: $depth, depthUnit: $depthUnit, visibility: $visibility, visibilityUnit: $visibilityUnit, diveType: $diveType, night: $night )
                .tabItem {
                    HStack {
                        Image(systemName: "ruler")
                        Text("Basic")
                    }
                }
                gearEntry(startPressure: $startPressure, endPressure: $endPressure, pressureUnit: $pressureUnit, airMix: $airMix, weight: $weight, weightUnit: $weightUnit, suit: $suit)
                .tabItem{
                    HStack {
                        Image(systemName: "backpack")
                        Text("Gear")
                    }
                }
                SetDiveLocationView(name: name, boat: $boatDive, saltWater: $saltWater, waterTemp: $waterTemp, airTemp: $airTemp, tempUnit: $tempUnit  )
                .tabItem {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Location")
                    }
                }
                Button("Press Me"){
//                    print(dive == nil)
                }
                    .tabItem {
                        HStack{
                            Image(systemName: "doc.richtext")
                            Text("Notes")
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        print("Done pressed")
                        newDive()
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Dive Entry")
        }
    }
    public func newDive() {
        let newDive = Dive(name: name, date: date, bottomTime: bottomTime, depth: depth, depthUnit: depthUnit, location: location, startPressure: startPressure, endPressure: endPressure, airUnit: pressureUnit, airMix: airMix, visibility: visibility, visibilityUnit: visibilityUnit, diveType: diveType, night: night, boatDive: boatDive, saltWater: saltWater, airTemp: airTemp, waterTemp: waterTemp, tempUnit: tempUnit)
        modelContext.insert(newDive)
        print("New Dive Entry")
    }
}

// MARK: Gear Entry Tab
struct gearEntry: View {
    @Binding public var startPressure: Int
    @Binding public var endPressure: Int
    @Binding public var pressureUnit: Bool
    @Binding public var airMix: Dive.AirMix
    
    @Binding public var weight: Int
    @Binding public var weightUnit: Bool
    @Binding public var suit: Int
    
    var body: some View {
        Form{
            Section(header: Text("Air")) {
                VStack {
                    HStack {
                        Text("Air Type:")
                            .foregroundStyle(.secondary)
                        Picker("", selection: $airMix) {
                            ForEach(Dive.AirMix.allCases) {option in
                            Text(String(describing: option))
                            }
                        }
                    }
                    HStack {
                        VStack {
                            HStack{
                                Text("Starting Pressure:")
                                    .foregroundStyle(.secondary)
                                TextField("Enter starting pressure", value: $startPressure, format: .number)
                                    .keyboardType(.numberPad)
                            }
                            HStack{
                                Text("Ending Pressure:")
                                    .foregroundStyle(.secondary)
                                TextField("Enter ending pressure", value: $endPressure, format: .number)
                                    .keyboardType(.numberPad)
                            }
                            
                        }
                        Picker("", selection: $pressureUnit) {
                            Text("bar").tag(true)
                            Text("psi").tag(false)
                        }
                    }
                }
            }
            Section(header: Text("Dive Suit")) {
                VStack{
                    HStack{
                        Text("Weights: ")
                            .foregroundStyle(.secondary)
                        TextField("Enter weight used", value: $weight, format: .number)
                            .keyboardType(.numberPad)
                        Picker("", selection: $weightUnit) {
                            Text("kg").tag(true)
                            Text("lb").tag(false)
                        }
                    }
                    HStack{
                        Text("Suit thickness")
                            .foregroundStyle(.secondary)
                        TextField("Enter suit thickness", value: $suit, format: .number)
                        Text("mm")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

// MARK: Location Entry Tab
struct LocationEntry: View {
    
    // TODO: Salt/Non Salt
    // TODO: Boat/Shore
    // TODO: Water Temp
    // TODO: Air Temp
    
    @State private var location: String = ""
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    @State private var name: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Location")) {
                    TextField("Enter dive location name here...", text: $location)
                    ZStack {
                        let map = Map()
                        {
                            Marker("Ocean", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 10)).tint(.red)
                        }
                        map
                            .mapControls {
                                MapUserLocationButton()
                                MapScaleView()
                            }
                        
                            .frame(width: 300, height: 300)
                        Image(systemName: "mappin").imageScale(.large)
                    }
                    HStack {
                        Button("Drop Pin"){
                            print("pin dropped")
                        }
                        Text("Location:")
                    }
                }
                Button("Press me"){
                    print("TEST")
                }
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return NewDiveView(/*dive: Dive.preview*/)
                .modelContainer(container)
    }
}
