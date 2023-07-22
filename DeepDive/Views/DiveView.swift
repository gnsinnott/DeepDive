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
                            diveOverviewCard(dive: dive)
                        } else if (index == 1){
                            gearViewCard(dive: dive)
                        }
                        else if (index == 2) {
                            diveLocationView(dive: dive)
                        }
                        else {
                            notesView()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 350)
                
                TabView(selection: $index) {
                    ForEach((0..<4), id: \.self) {index in
                        if (index == 0){
                            VStack {
                                diveOverviewText(dive: dive)
                                Spacer()
                            }
                        } else if (index == 1){
                            VStack {
                                gearViewText(dive: dive)
                                Spacer()
                            }
                        }
                        else if (index == 2) {
                            VStack {
                                diveLocationTextView(dive: dive)
                                Spacer()
                            }
                        }
                        else {
                            VStack {
                                notesViewText(dive: dive)
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
//            .toolbar(.hidden, for: .automatic) // Hide tab bar for all TabViews in current view
        }
//        .toolbar(.hidden, for: .automatic) // Hide tab bar for all TabViews in current view
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
            TankImage(start: dive.startPressure, end: dive.endPressure, airType: Dive.airMixFromId(airmix: dive.airMix), tankSize: dive.tankSize, tankSizeUnit: dive.tankSizeUnit)
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
        ZStack {
            Map(){
                Marker(dive.name, systemImage: "flag" , coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude))
            }
            .padding()
            Rectangle()
                .foregroundColor(Color.white.opacity(0.01))
            .padding()
        }
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
    var body: some View {
        dive.stampImage
        Rectangle()
            .fill(Color.purple)
            .frame(height: 100)
            .padding()
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