//
//  DataPoint.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 01/02/21.
//

import Foundation

struct DataPoint: Codable, Identifiable, Equatable {
    var timeOffset: TimeInterval
    var value: Measurement<UnitSpeed>
    var location: CodableLocation
    
    var id: TimeInterval {
        timeOffset
    }
    
    static func ==(lhs: DataPoint, rhs: DataPoint) -> Bool {
        lhs.id == rhs.id
    }
}
