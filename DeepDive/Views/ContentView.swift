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
                    NavigationLink(destination: DiveCard(dive: dive)) {
                        DiveCard(dive: dive)
                    }
                    .buttonStyle(.plain)
                }
                .navigationTitle("Your Dives")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading){
                    Label("Add Dive", systemImage: "plus")
                }
            }
        }
    }
}
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    MainActor.assumeIsolated {
    ContentView()
        .modelContainer(previewContainer)
    }
}
