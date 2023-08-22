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
    @Query(sort: \Dive.date, order: .reverse) var dives: [Dive]
    
    
    var body: some View {
        NavigationView {
            TabView {
                diveListView(dives: dives)
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
                SettingsView()
                    .tabItem {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
            }
        }
    }
}

//#Preview {
//    MainActor.assumeIsolated {
//        ContentView()
//            .modelContainer(previewContainer)
//    }
//}
