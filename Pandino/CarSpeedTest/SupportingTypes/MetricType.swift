//
//  MetricType.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 01/02/21.
//

import Foundation

enum MetricType: Int, Identifiable, CaseIterable {
    case km = 0
    case mph = 1
    
    var id: Int {
        return self.rawValue
    }
    
    var str: String {
        if self == .km { return "km/h" }
        else { return "mph" }
    }
}
