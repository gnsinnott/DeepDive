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
    
    var body: some View {
        Form{
            Section(header: Text("Air")) {
                VStack {
                    HStack {
                        Picker("", selection: $airMix) {
                            ForEach(Dive.AirMix.allCases) {option in
                                Text(String(describing: option))
                            }
                        }
                    }
                    HStack{
                        Text("Tank Size:")
                            .foregroundStyle(.secondary)
                        TextField("", value: $tankSize, formatter: Formatter.blankZeroFormat)
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
                                TextField("", value: $startPressure, formatter: Formatter.blankZeroFormat)
                                    .keyboardType(.numberPad)
                            }
                            HStack{
                                Text("Ending Pressure:")
                                    .foregroundStyle(.secondary)
                                TextField("", value: $endPressure, formatter: Formatter.blankZeroFormat)
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
                        TextField("", value: $weight, formatter: Formatter.blankZeroFormat)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $weightUnit) {
                            Text("kg").tag(true)
                            Text("lb").tag(false)
                        }
                    }
                    HStack{
                        Text("Suit thickness")
                            .foregroundStyle(.secondary)
                        TextField("", value: $suit, formatter: Formatter.blankZeroFormat)
                            .keyboardType(.numberPad)
                        Text("mm")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
//        .toolbar{
//            ToolbarItemGroup(placement: .keyboard){
//                Spacer()
//                Button() {
//                    print("On Gear Entry ")
//                    hideKeyboard()
//                } label: {
//                    Label("Dismiss Keyboard", systemImage: "keyboard.chevron.compact.down")
//                }
//            }
//        }
    }
}
