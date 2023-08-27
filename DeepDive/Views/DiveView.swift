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
    
    @State var image: Image?
    var dive: Dive
    var body: some View {
        ScrollView {
            Text("DETAILS")
                .font(.headline)
                .background(.teal)
            diveOverviewText(dive: dive)
            Spacer()
            Text("GEAR")
                .font(.headline)
                .background(.teal)
            gearText(dive: dive)
            Spacer()
            Text("LOCATION")
                .font(.headline)
                .background(.teal)
            diveLocationTextView(dive: dive)
            diveLocationView(dive: dive)
            Spacer()
            Text("NOTES")
                .font(.headline)
                .background(.teal)
            if let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(dive.id.uuidString)), let loaded = UIImage(data: data) {
//                    image = Image(uiImage: loaded)
                    notesView(dive: dive, image: Image(uiImage: loaded))
            } else {
                notesView(dive: dive)
            }
//            if image != nil {
//                
//            } else {
//                notesView(dive: dive)
//            }

            notesViewText(dive: dive)
        }
        .onAppear(){
            if let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(dive.id.uuidString)), let loaded = UIImage(data: data) {
                    image = Image(uiImage: loaded)
            }
        }
        .navigationTitle(dive.name)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink(destination: EditDiveView(dive: dive)){
                    Text("Edit")
                }
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
        }
    }
}

struct gearText: View {
    var dive: Dive
    var body: some View {
        let weightUnitText = (dive.weightUnit) ? "kgs" : "lbs"
        let tankSizeUnitText = (dive.tankSizeUnit) ? "liters" : "cu ft"
        let pressureUnitText = (dive.airUnit) ? "bar" : "psi"
        VStack{
            Text("Tank Mix: \(Dive.airMixFromId(airmix: dive.airMix))")
            Text("Tank Size: \(dive.tankSize) " + tankSizeUnitText)
            Text("Start: \(dive.startPressure) " + pressureUnitText)
            Text("End: \(dive.endPressure) " + pressureUnitText)
            Text("Weight: \(dive.weight) " + weightUnitText)
            Text("Suit: \(dive.suit) mm" )
            
        }
    }
}

struct diveLocationView: View {
    var dive: Dive
    var body: some View {
        VStack{
            Map(){
                Annotation(dive.name, coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude)){
                    Image(systemName: "flag.slash.fill")
                        .symbolEffect(.scale)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .red)
                        .tint(.gray)
                }
            }
//            .mapStyle(.hybrid)
            .frame(height: 350)
            .padding()
            Text("\(String(format: "%.6f", dive.latitude))˚\(dive.latitude >= 0 ? "N" : "S"), \(String(format: "%.6f", dive.longitude))˚\(dive.longitude >= 0 ? "E" : "W")")
        }
    }
}

struct diveLocationTextView: View {
    var dive: Dive
    var body: some View {
        VStack{
            Text(dive.location)
            Text(dive.boatDive ? "Boat Dive 🛥️" : "Shore Dive 🏝️")
            Text(dive.saltWater ? "Salt Water" : "Fresh Water")
            Text(String("Air: " + String(dive.airTemp)) + (dive.tempUnit ? " ˚C" : " ˚F"))
            Text(String("Water: " + String(dive.waterTemp)) + (dive.tempUnit ? " ˚C" : " ˚F"))
        }
    }
}

struct notesView: View {
    var dive: Dive
    @State var image: Image?
    var body: some View {
        if image != nil {
            HStack {
                image!
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
