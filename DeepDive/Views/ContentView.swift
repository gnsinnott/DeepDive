//
//  ContentView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dives: [Dive]
    
    var body: some View {
        TabView {
            diveList(dives: dives)
            .tabItem {
                Image(systemName: "water.waves")
            }
            Text("MAp")
                .tabItem{
                    Image(systemName: "globe")
                }
        }
    }
}


struct diveList: View {
    var dives: [Dive]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(dives) { dive in
                    NavigationLink(destination: UpdateDiveView(dive: dive)) {
                        DiveCard(dive: dive)
                    }
                    .buttonStyle(.plain)
                }
                .navigationTitle("Your Dives")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Label("Add Dive", systemImage: "plus")
                }
            }
        }
    }
}
#Preview {
    MainActor.assumeIsolated {
    ContentView()
        .modelContainer(previewContainer)
    }
}
