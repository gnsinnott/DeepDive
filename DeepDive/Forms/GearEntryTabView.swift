//
//  GearEntryTabView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/12/23.
//

import SwiftUI

struct gearEntryTabView: View {
    @Binding public var airMix: Dive.AirMix
    @Binding public var tankSize: Int
    @Binding public var tankSizeUnit: Bool
    @Binding public var startPressure: Int
    @Binding public var endPressure: Int
    @Binding public var pressureUnit: Bool
    
    
    @Binding public var weight: Int
    @Binding public var weightUnit: Bool
    @Binding public var suit: Int
    
    @FocusState private var focusedField: String?
    @FocusState private var isFocused: Bool
    
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
                    HStack{
                        Text("Tank Size:")
                            .foregroundStyle(.secondary)
                        TextField("Enter tank size", value: $tankSize, format: .number)
//                            .focused($isFocused)
//                            .focused($focusedField, equals: "tank")
                            .keyboardType(.numberPad)
                        Picker("", selection: $tankSizeUnit) {
                            Text("liters").tag(true)
                            Text("cu ft").tag(false)
                        }
                    }
                    HStack {
                        VStack {
                            HStack{
                                Text("Starting Pressure:")
                                    .foregroundStyle(.secondary)
                                TextField("Enter starting pressure", value: $startPressure, format: .number)
                                    .focused($focusedField, equals: "start")
                                    .keyboardType(.numberPad)
                            }
                            HStack{
                                Text("Ending Pressure:")
                                    .foregroundStyle(.secondary)
                                TextField("Enter ending pressure", value: $endPressure, format: .number)
                                    .focused($focusedField, equals: "end")
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
                            .focused($focusedField, equals: "weight")
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
                            .focused($focusedField, equals: "suit")
                            .keyboardType(.numberPad)
                        Text("mm")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
