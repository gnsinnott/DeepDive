//
//  DiveView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/29/23.
//

import SwiftUI
import MapKit

struct DiveView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State var presentDeleteAlert = false
    @State var index = 0
    var dive: Dive
    var body: some View {
        ScrollView {
            Text("Details")
                .font(.headline)
            diveOverviewText(dive: dive)
            Text("Location")
                .font(.headline)
            diveLocationView(dive: dive)
            diveLocationTextView(dive: dive)
            Text("Notes")
                .font(.headline)
            notesView(dive: dive)
            notesViewText(dive: dive)
        }
        .navigationTitle(dive.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    presentDeleteAlert = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .alert("Delete dive \(dive.name)?", isPresented: $presentDeleteAlert, actions: {
                    Button("Delete", role: .destructive, action: {
                        delete()
                    })
                    Button("Cancel", role: .cancel, action: {})
                })
            }
        }
    }
    public func delete() {
        modelContext.delete(dive)
        dismiss()
    }
}

struct diveOverviewText: View {
    var dive: Dive
    var body: some View {
        let weightUnitText = (dive.weightUnit) ? "kgs" : "lbs"
        let tankSizeUnitText = (dive.tankSizeUnit) ? "liters" : "cu ft"
        let pressureUnitText = (dive.airUnit) ? "bar" : "psi"
        ScrollView {
            VStack{
                HStack{
                    Image(systemName: dive.night ? "moon" : "sun.max")
                        .foregroundStyle(dive.night ? Color.blue : .orange)
                    Text(dive.date.formatted(date: .numeric, time: .omitted))
                }
                Text(Dive.diveTypeFromId(diveType: dive.diveType) + " Dive")
                Text("Time in: \(dive.date.formatted(date: .omitted, time: .shortened))")
                Text("Bottom Time: \(dive.bottomTime) minutes")
                Text("Depth: \(dive.depth) \(dive.depthUnit ? "m" : "ft")" )
                Text("Visibility: \(dive.visibility) \(dive.visibilityUnit ? "m" : "ft")")
                Spacer()
                Text("Gear")
                    .font(.headline)
                Text("Tank Mix: \(Dive.airMixFromId(airmix: dive.airMix))")
                Text("Tank Size: \(dive.tankSize) " + tankSizeUnitText)
                Text("Weight: \(dive.weight) " + weightUnitText)
                Text("Start: \(dive.startPressure) " + pressureUnitText)
                Text("End: \(dive.endPressure) " + pressureUnitText)
            }
        }
    }
}

struct diveLocationView: View {
    var dive: Dive
    var body: some View {
        Map(){
            Annotation(dive.name, coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude)){
                Image(systemName: "flag.slash.fill")
                    .symbolEffect(.scale)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .red)
                    .tint(.gray)
            }
        }
        .frame(height: 350)
        .padding()
    }
}

struct diveLocationTextView: View {
    var dive: Dive
    var body: some View {
        VStack{
            Text(dive.location)
            Text("\(String(format: "%.6f", dive.latitude))˚\(dive.latitude >= 0 ? "N" : "S"), \(String(format: "%.6f", dive.longitude))˚\(dive.longitude >= 0 ? "E" : "W")")
            Text(dive.boatDive ? "Boat Dive 🛥️" : "Shore Dive 🏝️")
            Text(dive.saltWater ? "Salt Water" : "Fresh Water")
            Text(String("Water: " + String(dive.waterTemp)) + (dive.tempUnit ? " ˚C" : " ˚F"))
            Text(String("Air: " + String(dive.airTemp)) + (dive.tempUnit ? " ˚C" : " ˚F"))
            Spacer()
        }
    }
}

struct notesView: View {
    var dive: Dive
    var body: some View {
        if let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(dive.id.uuidString)), let loaded = UIImage(data: data) {
            HStack {
                Image(uiImage: loaded)
                    .resizable()
                    .frame(height: 350)
            }
        }
    }
}

struct notesViewText: View {
    var dive: Dive
    var body: some View {
        ScrollView {
            VStack{
                Text(dive.note)
            }
            .padding()
        }
    }
}

//#Preview {
//    MainActor.assumeIsolated {
//        let container = previewContainer
//        return DiveView(dive: Dive.preview)
//            .modelContainer(container)
//    }
//}
