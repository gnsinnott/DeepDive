//
//  EditDiveView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 8/25/23.
//

import SwiftUI

struct EditDiveView: View {
    var dive: Dive
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var id: UUID?
    
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
    @State private var latitude: Double = 0.0
    
    @State private var note: String = ""
    @State private var stampImage: Image?
    
    @State var presentSubmitAlert = false
    
    @State private var viewSelection: String = "Basic"
    var viewOptions = ["Basic", "Gear", "Location", "Notes"]
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
                    Button("Save") {
                        let empty = notEntered()
                        if empty.isEmpty{
                            print("Submit pressed")
                            updateDive()
                            dismiss()
                        }
                        else {
                            presentSubmitAlert = true
                        }

                    }
                    .alert("Dive details missing", isPresented: $presentSubmitAlert, actions: {
                        Button("Submit", action: {
                            updateDive()
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
                SetDiveLocationView(name: name, longitude: $longitude, latitude: $latitude, location:$location, boat: $boatDive, saltWater: $saltWater, waterTemp: $waterTemp, airTemp: $airTemp, tempUnit: $tempUnit  )
            } else {
               let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(dive.id.uuidString))
                if (data != nil){
                    DiveNotesEntryView(id: id!, note: $note, stampImage: Image(uiImage: UIImage(data: data!)!))
                } else {
                    DiveNotesEntryView(id: id!, note: $note)
                }
                
            }
        }
        .pickerStyle(.segmented)
        .onAppear(){
            id = dive.id
            name = dive.name
            date = dive.date
            bottomTime = dive.bottomTime
            depth = dive.depth
            depthUnit = dive.depthUnit //true = m, false = ft
            visibility = dive.visibility
            visibilityUnit = dive.visibilityUnit //true = m, false = ft
            diveType = dive.diveType
            night = dive.night
            airMix = dive.airMix
            tankSize = dive.tankSize
            tankSizeUnit = dive.tankSizeUnit
            startPressure = dive.startPressure
            endPressure = dive.endPressure
            pressureUnit = dive.airUnit
            weight = dive.weight
            weightUnit = dive.weightUnit
            suit = dive.suit
            boatDive = dive.boatDive
            saltWater = dive.saltWater
            airTemp = dive.airTemp
            waterTemp = dive.waterTemp
            tempUnit = dive.tempUnit
            location = dive.location
            longitude = dive.longitude
            latitude = dive.latitude
        }
    }
    
    public func updateDive() {
        dive.name = name
        dive.date = date
        dive.bottomTime = bottomTime
        dive.depth = depth
        dive.depthUnit = depthUnit
        dive.visibility = visibility
        dive.visibilityUnit = visibilityUnit
        dive.diveType = diveType
        dive.night = night
        dive.airMix = airMix
        dive.tankSize = tankSize
        dive.tankSizeUnit = tankSizeUnit
        dive.startPressure = startPressure
        dive.endPressure = endPressure
        dive.airUnit = pressureUnit
        dive.weight = weight
        dive.weightUnit = weightUnit
        dive.suit = suit 
        dive.boatDive = boatDive
        dive.saltWater = saltWater
        dive.airTemp = airTemp
        dive.waterTemp = waterTemp
        dive.tempUnit = tempUnit
        dive.location = location
        dive.longitude = longitude
        dive.latitude = latitude
        dive.note = note
        print("New Dive Entry")
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
        return String(empty.dropLast(2)) // Remove comma and space from end of string
    }
}

//#Preview {
//    EditDiveView()
//}
