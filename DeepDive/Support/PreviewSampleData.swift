//
//  PreviewSampleData.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/13/23.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Dive.self, ModelConfiguration(inMemory: true))
        
        container.mainContext.insert(object: Dive(name:"First Dive", depth: 1))
        container.mainContext.insert(object: Dive(name:"Two Crabs", depth: 2))
        container.mainContext.insert(object: Dive(name:"Another Dive", depth: 3))
        container.mainContext.insert(object: Dive(name:"Homestead Ranch", depth: 4))
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
