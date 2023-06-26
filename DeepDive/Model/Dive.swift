//
//  Dive.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Dive {
    var id: UUID
    var name: String
    var date: Date
    var duration: Int
    var depth: Int
    var location: String
    var longitude: Double
    var latitude: Double
    var depthUnit: Bool
    var startPressure: Int
    var endPressure: Int
    var airUnit: Bool
    var airMix: Dive.AirMix
    
    init(name: String, date: Date, duration: Int, depth: Int, depthUnit: Bool, location: String, startPressure: Int, endPressure: Int, airUnit: Bool, airMix: AirMix){
        self.id = UUID()
        self.name = name
        self.date = date
        self.duration = duration
        self.depth = depth
        self.location = location
        self.longitude = 0.0
        self.latitude = 0.0
        self.depthUnit = depthUnit
        self.startPressure = startPressure
        self.endPressure = endPressure
        self.airUnit = airUnit
        self.airMix = airMix
    }
}

extension Dive: Identifiable { }

extension Dive {
    static var preview: Dive {
        Dive(name: "Test Dive", date: Date(), duration: 14, depth: 12, depthUnit: false, location: "Nowhere", startPressure: 3000, endPressure: 1000, airUnit: false, airMix: AirMix.Air )
    }
    
    enum AirMix: Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        case Air
        case Nitrox32
        case Nitrox36
        case Trimix
        case Heliox
    }
}
