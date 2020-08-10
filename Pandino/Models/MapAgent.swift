//
//  MapAgent.swift
//  Pandino
//
//  Created by Dani Tox on 11/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import MapKit

class MapAgent : ObservableObject {
    @Published var tipiStrings: [String] = ["Mappa", "Satellite", "Ibrido"]
    @Published var mapType: MKMapType = .standard
    @Published var mapTypeInteger: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.setMapType(from: self.mapTypeInteger)
            }
        }
    }
    
    
    
    public func setMapType(from intValue: Int) {
        switch intValue {
        case 0: mapType = .standard
        case 1: mapType = .satellite
        case 2: mapType = .hybrid
        default: mapType = .standard
        }
    }
    
}
