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
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date = Date()
    @State private var depth: Int = 0
    @State private var units = 0
    
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
//                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("Enter depth", value: $depth, format: .number)
                        Picker("", selection: $units) {
                            Text("meters").tag(0)
                            Text("feet").tag(1)
                        }
                    }
                }
            }
            .navigationTitle("Update Dive")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        updateDive()
    //                    WidgetCenter.shared.reloadTimelines(ofKind: "TripsWidget")
                        dismiss()
                    }
                }
            }
        }
        .onAppear{
            depth = dive.depth
            date = dive.date
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
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return UpdateDiveView(dive: Dive.preview)
                .modelContainer(container)
    }
}
