//
//  SpeedError.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 30/01/21.
//

import Foundation

enum SpeedError: Error, Equatable, Identifiable {
    case logicError
    case internalError(Error)
    case string(String)
    case speedGreaterThanMin
    case declinedLocationAccess
    case reducedLocatonAccuracy
    
    var stringValue: String {
        switch self {
        case .logicError:
            return "Logic error"
        case .string(let str): return str
        case .speedGreaterThanMin:
            return "The current speed is already greater than the lower bound of the speed range that you set"
        case .internalError(let err):
            return "\(err)"        
        case .declinedLocationAccess:
            return "You've declined access to the location. This app needs accurate location to be able to get the car's speed"
        case .reducedLocatonAccuracy:
            return "You've set \"reduced location accuracy\". This app needs accurate location to be able to get the car's speed"
        }
    }
    
    var isWarning: Bool {
        switch self {
        case .speedGreaterThanMin: return true
        default: return false
        }
    }
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: SpeedError, rhs: SpeedError) -> Bool {
        return lhs.id == rhs.id        
    }
    
}
