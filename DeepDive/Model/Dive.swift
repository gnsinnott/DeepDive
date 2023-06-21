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
    var unit: Bool
    
    init(name: String, date: Date, duration: Int, depth: Int, unit: Bool, location: String){
        self.id = UUID()
        self.name = name
        self.date = date
        self.duration = duration
        self.depth = depth
        self.location = location
        self.longitude = 0.0
        self.latitude = 0.0
        self.unit = unit
    }
}

extension Dive: Identifiable { }

extension Dive {
    static var preview: Dive {
        Dive(name: "Test Dive", date: Date(), duration: 14, depth: 12, unit: false, location: "Nowhere")
    }
}
