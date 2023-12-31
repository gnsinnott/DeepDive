//
//  Dive.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import Foundation
import SwiftData
import CoreLocation
import SwiftUI

// Unit bool, true = metric(meters,bar,celsius, etc) false = imperial(ft,psi,farenheit, etc)

@Model
class Dive {
    var id: UUID
    var number: Int
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
    var tankSize: Int
    var tankSizeUnit: Bool
    var visibility: Int
    var visibilityUnit: Bool
    var diveType: Dive.DiveType
    var night: Bool
    var boatDive: Bool
    var saltWater: Bool
    var airTemp: Double
    var waterTemp: Double
    var tempUnit: Bool
    var weight: Int
    var weightUnit: Bool
    var suit: Int
    var note: String
    
    init(id: UUID, number: Int, name: String, date: Date, bottomTime: Int, depth: Int, depthUnit: Bool, location: String, longitude: Double, latitude: Double, startPressure: Int, endPressure: Int, airUnit: Bool, airMix: AirMix, tankSize: Int, tankSizeUnit: Bool, visibility: Int, visibilityUnit: Bool, diveType: DiveType, night: Bool, boatDive: Bool, saltWater: Bool, airTemp: Double, waterTemp: Double, tempUnit: Bool, weight: Int, weightUnit: Bool, suit: Int, note: String){
        self.id = id
        self.number = number
        self.name = name
        self.date = date
        self.bottomTime = bottomTime
        self.depth = depth
        self.location = location
        self.longitude = longitude
        self.latitude = latitude
        self.depthUnit = depthUnit
        self.startPressure = startPressure
        self.endPressure = endPressure
        self.airUnit = airUnit
        self.airMix = airMix
        self.tankSize = tankSize
        self.tankSizeUnit = tankSizeUnit
        self.visibility = visibility
        self.visibilityUnit = visibilityUnit
        self.diveType = diveType
        self.night = night
        self.boatDive = boatDive
        self.saltWater = saltWater
        self.airTemp = airTemp
        self.waterTemp = waterTemp
        self.tempUnit = tempUnit
        self.weight = weight
        self.weightUnit = weightUnit
        self.suit = suit
        self.note = note
//        self.stampImage = stampImage
    }
}

extension Dive: Identifiable { }

extension Dive {
    static var preview: Dive {
        Dive(id: UUID(), number: 1, name: "Test Dive", date: Date(), bottomTime: 14, depth: 12, depthUnit: false, location: "Nowhere", longitude: 12.0, latitude: 3.0, startPressure: 3000, endPressure: 1000, airUnit: false, airMix: AirMix.Air, tankSize: 12, tankSizeUnit: true, visibility: 40, visibilityUnit: false, diveType: DiveType.Drift, night: false, boatDive: true, saltWater: true, airTemp: 90, waterTemp: 83, tempUnit: false, weight: 10, weightUnit: false, suit: 3, note: "Fun dive, got eaten by a shark.")
    }
    
    static func emptyDive() -> Dive {
        Dive(id: UUID(), number: 0, name: "", date: Date(), bottomTime: 0, depth: 0, depthUnit: true, location: "", longitude: 0.0, latitude: 0.0, startPressure: 0, endPressure: 0, airUnit: true, airMix: AirMix.Air, tankSize: 0, tankSizeUnit: true, visibility: 0, visibilityUnit: true, diveType: DiveType.Deep, night: false, boatDive: true, saltWater: true, airTemp: 32.5, waterTemp: 28, tempUnit: true, weight: 0, weightUnit: true, suit: 4, note: "")
    }
    
    enum AirMix: Int, Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        case Air
        case Nitrox
//        case Nitrox36
        case Trimix
        case Heliox
    }
    
    static func airMixFromId(airmix: AirMix) -> String {
        if (airmix == AirMix.Air){
            return "Air"
        } else if (airmix == AirMix.Nitrox) {
            return "Nitrox"
//        } else if (airmix == AirMix.Nitrox36) {
//            return "Nitrox36"
        } else if (airmix == AirMix.Trimix) {
            return "Trimix"
        } else {
            return "Heliox"
        }
    }
    
    enum DiveType: Int, Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        case Deep
        case Drift
        case Training
        case Well
        case Wreck
    }
    
    static func diveTypeFromId(diveType: DiveType) -> String {
        if (diveType == DiveType.Deep) {
            return "Deep"
        } else if (diveType == DiveType.Drift) {
            return "Drift"
        } else if (diveType == DiveType.Training) {
            return "Training"
        } else if (diveType == DiveType.Well) {
            return "Well"
        } else {
            return "Wreck"
        }
    }
}
