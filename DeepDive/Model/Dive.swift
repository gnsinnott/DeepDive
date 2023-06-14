//
//  Dive.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import Foundation
import SwiftData

@Model
class Dive {
    var id: UUID
    var name: String
    var date: Date
    var timeIn: Date
    var duration: Int
    var depth: Int
    var longitude: Double
    var latitude: Double
    
    init(name: String, depth: Int){
        self.id = UUID()
        self.name = name
        self.date = Date()
        self.duration = 38
        self.depth = depth
    }
}

extension Dive: Identifiable { }
