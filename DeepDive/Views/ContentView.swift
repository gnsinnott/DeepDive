//
//  ContentView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \.date, order: .reverse)
    var dives: [Dive]
    
    var body: some View {
        NavigationView {
            TabView {
                diveList(dives: dives)
                .tabItem {
                    HStack {
                        Image(systemName: "water.waves")
                        Text("Dives")
                    }
                }
                DiveMapView()
                .tabItem{
                    HStack {
                        Image(systemName: "globe")
                        Text("Map")
                    }
                }
                Text("Settings")
                .tabItem {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
            }
            .toolbar {
                NavigationLink(
                destination: NewDiveView(), label: {
                    Image(systemName: "plus")
                })
        }
    }
}


struct diveList: View {
    @State private var showingAlert = false
    @State private var navLinkActive = false
    @State private var name = "Test"
    var dives: [Dive]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(dives) { dive in
                    NavigationLink(destination: UpdateDiveView(dive: dive)) {
                        DiveCard(count: 1, dive: dive)
                    }
                    .buttonStyle(.plain)
                }
                .navigationTitle("Your Dives")
            }
//                Button {
//                    showingAlert = true
//                } label: {
//                    Label("New Dive", systemImage: "plus")
//                }
//                .alert("Enter New Dive Name", isPresented: $showingAlert) {
//                    TextField("Enter dive name", text: $name)
//                    Button("Create Dive") {
//                        submit()
//                        navLinkActive = true
//                    }
//                }
//                .navigationDestination(isPresented:$navLinkActive){
//                    NewDiveView()
//                }
            }
        }
    }
//    func submit() {
//        print("You entered \(name)")
//    }
}

#Preview {
    MainActor.assumeIsolated {
    ContentView()
        .modelContainer(previewContainer)
    }
}
