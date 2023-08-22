//
//  Race.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 10/02/21.
//

import Foundation
import CoreLocation

class RaceObject: Codable, Equatable, ObservableObject {
    private(set) var id: UUID = UUID()
    public var name: String { didSet { objectWillChange.send() } }
    public var date: Date
    public var dataPoints: [DataPoint]
    public var speedRange: ClosedRange<Int>
    public var duration: Double
    
    internal init(id: UUID = UUID(), name: String, date: Date, dataPoints: [DataPoint], speedRange: ClosedRange<Int>, duration: Double) {
        self.id = id
        self.name = name
        self.date = date
        self.dataPoints = dataPoints
        self.speedRange = speedRange
        self.duration = duration
    }
    
    static func == (lhs: RaceObject, rhs: RaceObject) -> Bool {
        return lhs.id == rhs.id
    }

}

struct CodableLocation: Codable {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var altitude: CLLocationDistance
    
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.altitude = location.altitude
    }
}
