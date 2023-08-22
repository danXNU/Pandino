//
//  Auth+Extension.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 29/01/21.
//

import Foundation
import CoreLocation

extension CLAuthorizationStatus {
    var stringValue: String {
        switch self {
        case .authorizedAlways: return "Always"
        case .authorizedWhenInUse: return "When in use"
        case .denied: return "Denied"
        case .notDetermined: return "Not determined"
        case .restricted: return "Restricted"
        default: return "Unknown"
        }
    }
}

extension CLAccuracyAuthorization {
    var stringValue: String {
        switch self {
        case .fullAccuracy: return "Full accuracy"
        case .reducedAccuracy: return "Reduced accuracy"
        default: return "Unkwnown"
        }
    }
}
