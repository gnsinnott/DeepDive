//
//  BasicEntryTabView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/29/23.
//

import SwiftUI

// MARK: Basic Entry Tab
struct basicEntryTabView: View{
    @Binding public var name: String
    @Binding public var date: Date
    @Binding public var bottomTime: Int
    @Binding public var depth: Int
    @Binding public var depthUnit: Bool
    @Binding public var visibility: Int
    @Binding public var visibilityUnit: Bool
    @Binding public var diveType: Dive.DiveType
    @Binding public var night: Bool
    
    @FocusState private var focusedField: String?
    @FocusState private var isFocused: Bool
    
    // TODO: First Dive number
    // TODO: Running dive number
    // TODO: Dive Number
    // TODO: Surface Interval - amount of time since last dive
    
    
    var body: some View {
        Form {
            Section(header: Text("Dive name")) {
                TextField("Enter dive name here...", text: $name)
                    .focused($focusedField, equals: "name")
            }
            Section(header: Text("Dive Date and Time")) {
                DatePicker(
                    "Time In:",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
                Toggle(night ? "Night Dive 🌙" : "Day Dive ☀️", isOn: $night)
                    .tint(Color.blue)
            }
            Section(header: Text("Dive Details")) {
                HStack {
                    Text("Depth:")
                        .foregroundStyle(.secondary)
                    TextField("Enter depth", value: $depth, format: .number)
                        .focused($isFocused)
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
                        .focused($isFocused)
                        .keyboardType(.numberPad)
                    Text("minutes")
                        .foregroundStyle(.secondary)
                }
                HStack{
                    Text("Visbility:")
                        .foregroundStyle(.secondary)
                    TextField("Enter visibility", value: $visibility, format: .number)
                        .focused($isFocused)
                        .keyboardType(.numberPad)
                    Picker("", selection: $visibilityUnit) {
                        Text("meters").tag(true)
                        Text("feet").tag(false)
                    }
                }
                HStack{
                    Text("Dive Type:")
                        .foregroundStyle(.secondary)
                    Picker("", selection: $diveType) {
                        ForEach(Dive.DiveType.allCases) {option in
                            Text(String(describing: option))
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button() {
                    hideKeyboard()
                } label: {
                    Label("Dismiss Keyboard", systemImage: "keyboard.chevron.compact.down")
                }
            }
        }

    }
}
