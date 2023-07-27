//
//  DiveListView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/29/23.
//

import SwiftUI

struct diveListView: View {
    @State private var showingAlert = false
    @State private var navLinkActive = false
    @State private var name = "Test"
    var dives: [Dive]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(dives) { dive in
                    NavigationLink(destination: DiveView(dive: dive)) {
                        DiveCard(count: 1, dive: dive)
                    }
                    .buttonStyle(.plain)
                }
                .toolbar {
                    NavigationLink(
                        destination: NewDiveView(), label: {
                            Label("New Dive", systemImage: "plus")
                        })
                }
                .navigationTitle("Your Dives")
            }
        }
    }
}
