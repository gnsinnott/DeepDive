//
//  PreviewSampleData.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/13/23.
//

import SwiftData
import SwiftUI

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Dive.self, ModelConfiguration(inMemory: true))
        
        container.mainContext.insert(object: Dive(name:"Short Title", date: Date(), duration: 20, depth: 1, unit: false))
        container.mainContext.insert(object: Dive(name:"Very extra super long dive title why so long?", date: Date(), duration: 49, depth: 2, unit: false))
        container.mainContext.insert(object: Dive(name:"Another Dive", date: Date(), duration: 36, depth: 3, unit: true))
        container.mainContext.insert(object: Dive(name:"Homestead Ranch", date: Date(), duration: 57, depth: 4, unit: true))
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
