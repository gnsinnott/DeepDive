//
//  DiveView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/29/23.
//

import SwiftUI

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
                            diveLocationView()
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
                            diveOverviewText(dive: dive)
                        } else if (index == 1){
                            gearViewText(dive: dive)
                        }
                        else if (index == 2) {
                            diveLocationView()
                        }
                        else {
                            notesView()
                        }
                    }
                }
                .padding()
                
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
        VStack{
            HStack{
                Image(systemName: dive.night ? "moon" : "sun.max")
                    .foregroundStyle(dive.night ? Color.blue : .orange)
                Text(dive.date.formatted(date: .numeric, time: .omitted))
            }
            Text(Dive.diveTypeFromId(diveType: dive.diveType))
            Text("Time in: \(dive.date.formatted(date: .omitted, time: .shortened))")
            Text("Bottom Time: \(dive.bottomTime) minutes")
            Text("Depth: \(dive.depth) \(dive.depthUnit ? "m" : "ft")" )
            Text("Visibility: \(dive.visibility) \(dive.visibilityUnit ? "m" : "ft")")
        }
        
    }
}

struct gearViewCard: View {
    var dive: Dive
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .blur(radius: 7.0)
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
        VStack{
            Text("Gear Details")
                .font(.title)
            Text("Air Mix: \(Dive.airMixFromId(airmix: dive.airMix))")
            Text("Tank Size: \(dive.tankSize) " + tankSizeUnitText)
            Text("Weight: \(dive.weight) " + weightUnitText)
            Text("Start: \(dive.startPressure) " + pressureUnitText)
            Text("End: \(dive.endPressure) " + pressureUnitText)
            
        }
    }
}



struct diveLocationView: View {
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(height: 350)
            .padding()
    }
}

struct notesView: View {
    var body: some View {
        Rectangle()
            .fill(Color.purple)
            .frame(height: 350)
            .padding()
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
        return DiveView(dive: Dive.preview)
            .modelContainer(container)
    }
}
