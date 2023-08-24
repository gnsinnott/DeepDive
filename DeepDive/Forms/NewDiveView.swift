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
    
    @AppStorage("diveNumber") var diveNumber = 1
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("defaultUnit") var defaultUnit: Bool?
    let id = UUID()
    
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
    
    @State var presentSubmitAlert = false
    
    @State private var viewSelection: String = "Basic"
    var viewOptions = ["Basic", "Gear", "Location", "Notes"]
    var viewLogos = [Image(systemName: "ruler")]
    var body: some View {
        NavigationStack {
            Picker("Entry", selection: $viewSelection) {
                ForEach(viewOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        let empty = notEntered()
                        if empty.isEmpty{
                            print("Submit pressed")
                            newDive()
                            dismiss()
                        }
                        else {
                            presentSubmitAlert = true
                        }

                    }
                    .alert("Dive details missing", isPresented: $presentSubmitAlert, actions: {
                        Button("Submit", action: {
                            newDive()
                            dismiss()
                        })
                        Button("Cancel", role: .cancel, action: {})
                    },message: {
                        let empty = notEntered()
                        Text("Items Missing: \(empty)")
                    })
                    
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button() {
                        print("Main Form")
                        hideKeyboard()
                    } label: {
                        Label("Dismiss Keyboard", systemImage: "keyboard.chevron.compact.down")
                    }
                }
            }
            .navigationTitle("New Dive Entry")
            if viewSelection == viewOptions[0] {
                basicEntryTabView(name: $name, date: $date, bottomTime: $bottomTime, depth: $depth, depthUnit: $depthUnit, visibility: $visibility, visibilityUnit: $visibilityUnit, diveType: $diveType, night: $night )
            } else if viewSelection == viewOptions[1] {
                gearEntryTabView(airMix: $airMix, tankSize: $tankSize, tankSizeUnit: $tankSizeUnit, startPressure: $startPressure, endPressure: $endPressure, pressureUnit: $pressureUnit, weight: $weight, weightUnit: $weightUnit, suit: $suit)
            } else if viewSelection == viewOptions[2] {
                SetDiveLocationView(name: name, longitude: $longitude, latitude: $latitutde, location:$location, boat: $boatDive, saltWater: $saltWater, waterTemp: $waterTemp, airTemp: $airTemp, tempUnit: $tempUnit  )
            } else {
                DiveNotesEntryView(id: id, note: $note, stampImage: $stampImage)
            }
        }
        .pickerStyle(.segmented)
        .onAppear(){
            if (defaultUnit != nil){
                depthUnit = defaultUnit!
                visibilityUnit = defaultUnit!
                tankSizeUnit = defaultUnit!
                pressureUnit = defaultUnit!
                weightUnit = defaultUnit!
                tempUnit = defaultUnit!
            }
        }
    }
    
    public func newDive() {
        let newDive = Dive(id: id, number: diveNumber , name: name, date: date, bottomTime: bottomTime, depth: depth, depthUnit: depthUnit, location: location, longitude: longitude, latitude: latitutde, startPressure: startPressure, endPressure: endPressure, airUnit: pressureUnit, airMix: airMix, tankSize: tankSize, tankSizeUnit: tankSizeUnit, visibility: visibility, visibilityUnit: visibilityUnit, diveType: diveType, night: night, boatDive: boatDive, saltWater: saltWater, airTemp: airTemp, waterTemp: waterTemp, tempUnit: tempUnit, weight: weight, weightUnit: weightUnit, note: note)
        modelContext.insert(newDive)
        diveNumber += 1
        print("New Dive Entry")
        print("New dive number \(diveNumber)")
    }
    
    public func notEntered() -> String{
        var empty = ""
        if name == "" {
            empty.append("Name, ")
        }
        if bottomTime == 0 {
            empty.append("Bottom Time, ")
        }
        if depth == 0 {
            empty.append("Depth, ")
        }
        if startPressure == 0 {
            empty.append("Start Pressure, ")
        }
        if endPressure == 0 {
            empty.append("End Pressure, ")
        }
        if tankSize == 0 {
            empty.append("Tank Size, ")
        }
        if weight == 0 {
            empty.append("Weight, ")
        }
        if visibility == 0 {
            empty.append("Visibility, ")
        }
        if airTemp == 0 {
            empty.append("Air Temp, ")
        }
        if waterTemp == 0 {
            empty.append("Water Temp, ")
        }
        print(empty)
        return String(empty.dropLast(2)) // Remove comma and space from end of string
    }
}

//#Preview {
//    MainActor.assumeIsolated {
//        let container = previewContainer
//        return NewDiveView(/*dive: Dive.preview*/)
//                .modelContainer(container)
//    }
//}
