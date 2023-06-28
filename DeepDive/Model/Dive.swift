//
//  Dive.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import Foundation
import SwiftData
import CoreLocation

// Unit bool, true = metric(meters,bar,etc) false = imperial(ft, psi, etc)

@Model
class Dive {
    var id: UUID
    var name: String
    var date: Date
    var bottomTime: Int
    var depth: Int
    var location: String
    var longitude: Double
    var latitude: Double
    var depthUnit: Bool
    var startPressure: Int
    var endPressure: Int
    var airUnit: Bool
    var airMix: Dive.AirMix
    var visibility: Int
    var visibilityUnit: Bool
    var diveType: Dive.DiveType
    var night: Bool
    
    init(name: String, date: Date, bottomTime: Int, depth: Int, depthUnit: Bool, location: String, startPressure: Int, endPressure: Int, airUnit: Bool, airMix: AirMix, visibility: Int, visibilityUnit: Bool, diveType: DiveType, night: Bool){
        self.id = UUID()
        self.name = name
        self.date = date
        self.bottomTime = bottomTime
        self.depth = depth
        self.location = location
        self.longitude = 0.0
        self.latitude = 0.0
        self.depthUnit = depthUnit
        self.startPressure = startPressure
        self.endPressure = endPressure
        self.airUnit = airUnit
        self.airMix = airMix
        self.visibility = visibility
        self.visibilityUnit = visibilityUnit
        self.diveType = diveType
        self.night = night
    }
}

extension Dive: Identifiable { }

extension Dive {
    static var preview: Dive {
        Dive(name: "Test Dive", date: Date(), bottomTime: 14, depth: 12, depthUnit: false, location: "Nowhere", startPressure: 3000, endPressure: 1000, airUnit: false, airMix: AirMix.Air, visibility: 40, visibilityUnit: false, diveType: DiveType.Drift, night: false)
    }
    
    static func emptyDive() -> Dive {
        Dive(name: "", date: Date(), bottomTime: 0, depth: 0, depthUnit: true, location: "", startPressure: 0, endPressure: 0, airUnit: true, airMix: AirMix.Air, visibility: 0, visibilityUnit: true, diveType: DiveType.Deep, night: false)
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
        
        var description: String {
            switch self {
            case .Air:
              return "Air"
            case .Nitrox32:
              return "Nitrox32"
            default:
                return "Other"
            }
          }
    }
    
    enum DiveType: Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        case Deep
        case Drift
        case Training
        case Well
        case Wreck
        
    }
}
