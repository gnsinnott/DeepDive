//
//  DiveView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/29/23.
//

import SwiftUI
import MapKit

struct DiveView: View {
    @State var index = 0
    var dive: Dive
    var body: some View {
        Group {
            VStack{
                Text(dive.name)
                    .font(.largeTitle)
                TabView(selection: $index) {
                    ForEach((0..<4), id: \.self) {index in
                        if (index == 0){
                        
                            VStack {
                                diveOverviewCard(dive: dive)
                                diveOverviewText(dive: dive)
                            }
                            
                        } else if (index == 1){
                            VStack{
                                gearViewCard(dive: dive)
                                gearViewText(dive: dive)
                                Spacer()
                            }
                        }
                        else if (index == 2) {
                            VStack{
                                diveLocationView(dive: dive)
                                diveLocationTextView(dive: dive)
                            }
                        }
                        else {
                            VStack{
                                notesView(dive: dive)
                                notesViewText(dive: dive)
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
}

struct diveOverviewCard: View {
    var dive: Dive
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(height: 350)
            .padding()
    }
}

struct diveOverviewText: View {
    var dive: Dive
    var body: some View {
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
            }
        }
        
    }
}

struct gearViewCard: View {
    var dive: Dive
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 350)
                .padding()
            HStack(spacing: 60) {
                TankImage(start: dive.startPressure, end: dive.endPressure, airType: Dive.airMixFromId(airmix: dive.airMix), tankSize: dive.tankSize, tankSizeUnit: dive.tankSizeUnit)
                WeightImage(weight: dive.weight, unit: dive.weightUnit)
            }
        }
    }
}

struct gearViewText: View {
    var dive: Dive
    var body: some View {
        let weightUnitText = (dive.weightUnit) ? "kgs" : "lbs"
        let tankSizeUnitText = (dive.tankSizeUnit) ? "liters" : "cu ft"
        let pressureUnitText = (dive.airUnit) ? "bar" : "psi"
        ScrollView {
            VStack{
                Text("Air Mix: \(Dive.airMixFromId(airmix: dive.airMix))")
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
            Marker(dive.name, systemImage: "flag" , coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude))
        }
//        .padding()
        .frame(height: 350)
    }
}

struct diveLocationTextView: View {
    var dive: Dive
    var body: some View {
        VStack{
            Text(dive.location)
            Text("Location coordinates")
            Text(dive.boatDive ? "Boat Dive 🛥️" : "Shore Dive 🏝️")
            Text(dive.saltWater ? "Salt Water" : "Fresh Water")
            Text(String(dive.airTemp) + (dive.airUnit ? " ˚C" : " ˚F"))
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

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return DiveView(dive: Dive.preview)
            .modelContainer(container)
    }
}
