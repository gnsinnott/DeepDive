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
//    var location: CLLocationCoordinate2D
    var longitude: Double
    var latitude: Double
    var unit: Bool
    
    init(name: String, depth: Int){
        self.id = UUID()
        self.name = name
        self.date = Date()
        self.duration = 38
        self.depth = depth
        self.longitude = 0.0
        self.latitude = 0.0
        self.unit = false // false/0 = meters, true/1 = feet
    }
}

extension Dive: Identifiable { }

extension Dive {
    static var preview: Dive {
        Dive(name: "Test Dive", depth: 12)
    }
}
