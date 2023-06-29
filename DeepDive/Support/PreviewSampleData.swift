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
        
        container.mainContext.insert(object: Dive(name:"Short Title", date: Date()+7200, bottomTime: 20, depth: 1, depthUnit: false, location: "Somewhwere", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, visibility: 30, visibilityUnit: true, diveType: Dive.DiveType.Training, night: false, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false))
        container.mainContext.insert(object: Dive(name:"Very extra super long dive title why so long?", date: Date()-7200, bottomTime: 49, depth: 2, depthUnit: false, location: "Roatan", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, visibility: 3, visibilityUnit: true, diveType: Dive.DiveType.Training, night: true, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false))
        container.mainContext.insert(object: Dive(name:"Another Dive", date: Date(), bottomTime: 36, depth: 3, depthUnit: true, location: "Egypt", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, visibility: 80, visibilityUnit: false, diveType: Dive.DiveType.Training, night: false, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false))
        container.mainContext.insert(object: Dive(name:"Homestead Ranch", date: Date(), bottomTime: 57, depth: 4, depthUnit: true, location: "", startPressure: 3000, endPressure: 100, airUnit: false, airMix: Dive.AirMix.Nitrox32, visibility: 12, visibilityUnit: true, diveType: Dive.DiveType.Deep, night: true, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false))
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
