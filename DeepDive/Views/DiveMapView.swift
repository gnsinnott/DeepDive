//
//  DiveMapView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/17/23.
//

import SwiftUI
import SwiftData
import MapKit

struct DiveSite: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
}

struct DiveMapView: View {
    let image = Image("DiveFlagImage")
    @Environment(\.displayScale) var displayScale
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \.date, order: .reverse)
    var dives: [Dive]
    
    var body: some View {
        NavigationStack {
            VStack {
                Map(){
                    ForEach(dives) { dive in
                        Marker(dive.name, systemImage: "flag" , coordinate: CLLocationCoordinate2D(latitude: dive.latitude, longitude: dive.longitude))
                            .tint(.teal)
                    }
                }
                Spacer()
            }
        }
    }
}



#Preview {
    MainActor.assumeIsolated {
        DiveMapView()
            .modelContainer(previewContainer)
    }
}
