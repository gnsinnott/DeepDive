//
//  NumberFormatters.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 8/16/23.
//

import Foundation

extension Formatter {
    static let blankZeroFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
//        formatter.minusSign   = "👺 "  // Just for fun!
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}
