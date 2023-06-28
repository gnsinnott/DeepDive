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
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var bottomTime: Int = 0
    @State private var depth: Int = 0
    @State private var depthUnit: Bool = true //true = m, false = ft
    
    
    @State private var airMix: Dive.AirMix = .Air
    @State private var startPressure = 0
    @State private var endPressure = 0
    @State private var pressureUnit = true //true = bar, false = psi
    @State private var weight = 0
    @State private var weightUnit = true //true = kg, fales = lbs
    @State private var suit = 0
    
    
    @State private var location: String = ""
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    
    // TODO: Notes and stamp section
    
    
    var body: some View {
        NavigationStack {
            TabView {
                basicEntry(name: $name, date: $date, bottomTime: $bottomTime, depth: $depth, depthUnit: $depthUnit)
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
                DiveMapView()
                .tabItem {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Location")
                    }
                }
                Text("Notes")
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
        let newDive = Dive(name: name, date: date, bottomTime: bottomTime, depth: depth, depthUnit: depthUnit, location: location, startPressure: startPressure, endPressure: endPressure, airUnit: pressureUnit, airMix: airMix)
        modelContext.insert(newDive)
        print(name)
        print("New Dive Entry")
    }
}

struct basicEntry: View{
    @Binding public var name: String
    @Binding public var date: Date
    @Binding public var bottomTime: Int
    @Binding public var depth: Int
    @Binding public var depthUnit: Bool
    
    
    // TODO: First Dive number
    // TODO: Running dive number
    // TODO: Dive Number
    // TODO: Visibility ft/m
    // TODO: Dive Type, Drift, Wreck, Deep, Wall, Training
    // TODO: Day/Night, use icons, highlight based on???
    // TODO: Surface Interval - amount of time since last dive
    
    
    var body: some View {
        Form {
            Section(header: Text("Dive name")) {
                TextField("Enter dive name here...", text: $name)
            }
            Section(header: Text("Dive Date and Time")) {
                DatePicker(
                    "Time In:",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            Section(header: Text("Dive Details")) {
                HStack {
                    Text("Depth:")
                        .foregroundStyle(.secondary)
                    TextField("Enter depth", value: $depth, format: .number)
                        .keyboardType(.numberPad)
                    Picker("", selection: $depthUnit) {
                        Text("meters").tag(true)
                        Text("feet").tag(false)
                    }
                }
                HStack {
                    Text("Bottom Time:")
                        .foregroundStyle(.secondary)
                    TextField("Enter bottom time", value: $bottomTime, format: .number)
                        .keyboardType(.numberPad)
                    Text("minutes")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

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
struct LocationEntry: View {
    
    // TODO: Salt/Non Salt
    // TODO: Boat/Shore
    // TODO: Water Temp
    // TODO: Air Temp
    
    @State private var location: String = ""
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    
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
        return NewDiveView()
                .modelContainer(container)
    }
}
