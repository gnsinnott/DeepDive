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
    
    @State private var airMix: Dive.AirMix = Dive.AirMix.Air
    @State private var tankSize: Int = 0
    @State private var tankSizeUnit: Bool = true //true = liter, false = cu ft
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
    
    @State private var note: String = ""
    @State private var stampImage: Image?
    
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
                gearEntryTabView(airMix: $airMix, tankSize: $tankSize, tankSizeUnit: $tankSizeUnit, startPressure: $startPressure, endPressure: $endPressure, pressureUnit: $pressureUnit, weight: $weight, weightUnit: $weightUnit, suit: $suit)
                .tabItem{
                    HStack {
                        Image(systemName: "backpack")
                        Text("Gear")
                    }
                }
                SetDiveLocationView(name: name, longitude: $longitude, latitude: $latitutde, boat: $boatDive, saltWater: $saltWater, waterTemp: $waterTemp, airTemp: $airTemp, tempUnit: $tempUnit  )
                .tabItem {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Location")
                    }
                }
                DiveNotesEntryView(note: $note, stampImage: $stampImage)
                    .tabItem {
                        HStack{
                            Image(systemName: "doc.richtext")
                            Text("Notes")
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        print("Submit pressed")
                        newDive()
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Dive Entry")
        }
    }
    public func newDive() {
        let newDive = Dive(name: name, date: date, bottomTime: bottomTime, depth: depth, depthUnit: depthUnit, location: location, longitude: longitude, latitude: latitutde, startPressure: startPressure, endPressure: endPressure, airUnit: pressureUnit, airMix: airMix, tankSize: tankSize, tankSizeUnit: tankSizeUnit, visibility: visibility, visibilityUnit: visibilityUnit, diveType: diveType, night: night, boatDive: boatDive, saltWater: saltWater, airTemp: airTemp, waterTemp: waterTemp, tempUnit: tempUnit, weight: weight, weightUnit: weightUnit, note: note, stampImage: stampImage)
        modelContext.insert(newDive)
        print("New Dive Entry")
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return NewDiveView(/*dive: Dive.preview*/)
                .modelContainer(container)
    }
}
