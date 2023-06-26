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
    @State private var duration: Int = 0
    @State private var depth: Int = 0
    @State private var depthUnit: Bool = true //true = m, false = ft
    
    
    @State private var airMix: Dive.AirMix = .Air
    @State private var startPressure = 0
    @State private var endPressure = 0
    @State private var pressureUnit = true //true = bar, false = psi
    
    @State private var location: String = ""
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    
    var body: some View {
        NavigationStack {
            TabView {
                basicEntry(name: $name, date: $date, duration: $duration, depth: $depth, depthUnit: $depthUnit)
                .tabItem {
                    HStack {
                        Image(systemName: "ruler")
                        Text("Basic")
                    }
                }
                gearEntry(startPressure: $startPressure, endPressure: $endPressure, pressureUnit: $pressureUnit, airMix: $airMix)
                .tabItem{
                    HStack {
                        Image(systemName: "backpack")
                        Text("Gear")
                    }
                }
                LocationEntry()
                .tabItem {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Location")
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
        let newDive = Dive(name: name, date: date, duration: duration, depth: depth, depthUnit: depthUnit, location: location, startPressure: startPressure, endPressure: endPressure, airUnit: pressureUnit, airMix: airMix)
        modelContext.insert(newDive)
        print(name)
        print("New Dive Entry")
    }
}

struct basicEntry: View{
    @Binding public var name: String
    @Binding public var date: Date
    @Binding public var duration: Int
    @Binding public var depth: Int
    @Binding public var depthUnit: Bool
    
    
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
                    Text("Duration:")
                        .foregroundStyle(.secondary)
                    TextField("Enter duration", value: $duration, format: .number)
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
        }
    }
}
struct LocationEntry: View {
    
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
