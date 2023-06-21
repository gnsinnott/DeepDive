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
    @State private var longitude: Double = 0.0
    @State private var latitutde: Double = 0.0
    @State private var unit: Bool = true
    @State private var location: String = ""
    
    var body: some View {
        NavigationStack {
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
                        Picker("", selection: $unit) {
                            Text("meters").tag(true)
                            Text("feet").tag(false)
                        }
                    }
                    HStack {
                        Text("Duration:")
                            .foregroundStyle(.secondary)
                        TextField("Enter duration", value: $duration, format: .number)
                        Text("minutes")
                            .foregroundStyle(.secondary)
                    }
                }
                Section(header: Text("Location")) {
                    TextField("Enter dive location  here...", text: $location)
                    ZStack {
                        
                        let map = Map()
                        map
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
            .navigationTitle("New Dive Entry")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        newDive()
                        dismiss()
                    }
                }
            }
        }
    }
    private func newDive() {
        let newDive = Dive(name: name, date: date, duration: duration, depth: depth, unit: unit, location: location)
        modelContext.insert(newDive)
        print("New Dive Entry")
    }
}



#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return NewDiveView()
                .modelContainer(container)
    }
}
