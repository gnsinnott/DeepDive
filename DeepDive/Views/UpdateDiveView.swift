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
    @State private var duration: Int = 0
    @State private var unit = true
    
    var body: some View {
        NavigationStack {
            Form{
                Section(header: Text("Dive name")) {
                    TextField(dive.name.isEmpty ? "Enter dive name here..." : dive.name, text: $name)
                }
                Section(header: Text("Dive date")) {
                    DatePicker(
                    "Dive Date",
                    selection: $date,
                    displayedComponents: [.date]
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
            Button(role: .destructive) { delete() } label: {
                                Label("Delete Dive", systemImage: "trash")
                            }
        }
        .onAppear{
            name = dive.name
            date = dive.date
            duration = dive.duration
            depth = dive.depth
            unit = dive.unit
        }
    }
    private func updateDive() {
        print("Test Done button")
        if !name.isEmpty {
            dive.name = name
        }
        dive.depth = depth
        dive.date = date
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
