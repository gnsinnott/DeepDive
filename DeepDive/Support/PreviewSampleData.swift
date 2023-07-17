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
        var longString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget mi lobortis, placerat risus at, venenatis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce cursus velit eu eros fermentum viverra. Morbi eu mauris mattis, gravida eros quis, blandit elit. Ut ut quam varius, blandit lectus non, lacinia lacus. Curabitur congue feugiat fermentum. Nulla at diam neque. In posuere dui quis neque aliquam egestas. Sed a porttitor neque. Nunc posuere congue eleifend. Nullam sit amet purus nec nisl consectetur viverra. Vivamus nisl erat, convallis a metus ultricies, elementum interdum nisi. Morbi a nulla dictum, hendrerit nisi a, viverra ante. Cras euismod libero dolor, ut pretium neque tempus ac. Sed fermentum bibendum sodales. Etiam et consectetur arcu. Vivamus a mi efficitur eros imperdiet placerat vel vitae sapien. Ut at auctor justo, non tincidunt ipsum. Nullam placerat nisl at dui hendrerit dapibus. Nam odio libero, mattis nec vestibulum in, egestas et turpis. Suspendisse potenti."
        container.mainContext.insert(object: Dive(name:"Short Title", date: Date()+7200, bottomTime: 20, depth: 1, depthUnit: false, location: "Somewhwere", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, tankSize: 12, tankSizeUnit: true, visibility: 30, visibilityUnit: true, diveType: Dive.DiveType.Training, night: false, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false, weight: 4, weightUnit: true, note: "Short Note"))
        container.mainContext.insert(object: Dive(name:"Very extra super long dive title why so long?", date: Date()-7200, bottomTime: 49, depth: 2, depthUnit: false, location: "Roatan", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, tankSize: 15, tankSizeUnit: true, visibility: 3, visibilityUnit: true, diveType: Dive.DiveType.Training, night: true, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false, weight: 10, weightUnit: false, note: longString))
        container.mainContext.insert(object: Dive(name:"Another Dive", date: Date(), bottomTime: 36, depth: 3, depthUnit: true, location: "Egypt", startPressure: 3000, endPressure: 500, airUnit: false, airMix: Dive.AirMix.Air, tankSize: 80, tankSizeUnit: false, visibility: 80, visibilityUnit: false, diveType: Dive.DiveType.Training, night: false, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false, weight: 10, weightUnit: false, note: "We ate the shark this time."))
        container.mainContext.insert(object: Dive(name:"Homestead Ranch", date: Date(), bottomTime: 57, depth: 4, depthUnit: true, location: "", startPressure: 3000, endPressure: 100, airUnit: false, airMix: Dive.AirMix.Nitrox32, tankSize: 80, tankSizeUnit: false, visibility: 12, visibilityUnit: true, diveType: Dive.DiveType.Deep, night: true, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false, weight: 10, weightUnit: false, note: "Well the water was warm but the scenery was lacking."))
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
