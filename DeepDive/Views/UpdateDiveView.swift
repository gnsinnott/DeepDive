//
//  DiveDetail.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/14/23.
//

import SwiftUI
import SwiftData

struct UpdateDiveView: View {
    var dive: Dive
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date = Date()
    @State private var depth: Int = 0
    @State private var bottomTime: Int = 0
    @State private var depthUnit = true
    @State private var location = ""
    
    var body: some View {
        NavigationStack {
            Form{
                Section(header: Text("Dive name")) {
                    TextField("Enter dive name", text: $name)
                }
                Section(header: Text("Dive date")) {
                    DatePicker(
                    "Dive Date",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                    )
                }
                Section(header: Text("Dive Details")) {
                    HStack {
                        Text("Depth:")
                            .foregroundStyle(.secondary)
                        TextField("Enter depth", value: $depth, format: .number)
                        Picker("", selection: $depthUnit) {
                            Text("meters").tag(true)
                            Text("feet").tag(false)
                        }
                    }
                    HStack {
                        Text("Bottom Time:")
                            .foregroundStyle(.secondary)
                        TextField("Enter bottom Time", value: $bottomTime, format: .number)
                        Text("minutes")
                            .foregroundStyle(.secondary)
                    }
                }
                Section(header: Text("Location")) {
                    TextField("Enter dive location  here...", text: $location)
//                    ZStack {
//                        
//                        let map = Map()
//                        map
//                            .frame(width: 300, height: 300)
//                        Image(systemName: "mappin").imageScale(.large)
//                    }
                    HStack {
                        Button("Drop Pin"){
                            print("pin dropped")
                        }
                        Text("Location:")
                    }
                }
            }
            .navigationTitle("Update Dive")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        updateDive()
                        dismiss()
                    }
                }
            }
            Button(role: .destructive) {
                dismiss()
                delete()
            } label: {
                Label("Delete Dive", systemImage: "trash")
            }
        }
        .onAppear{
            name = dive.name
            date = dive.date
            bottomTime = dive.bottomTime
            depth = dive.depth
            depthUnit = dive.depthUnit
            location = dive.location
        }
    }
    private func updateDive() {
        print("Test Done button")
        if !name.isEmpty {
            dive.name = name
        }
        dive.depth = depth
        dive.date = date
        dive.bottomTime = bottomTime
        dive.location = location
    }
    private func delete() {
        print("Delete")
        modelContext.delete(dive)
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return UpdateDiveView(dive: Dive.preview)
                .modelContainer(container)
    }
}
