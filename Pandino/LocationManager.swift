//
//  LocationManager.swift
//  Pandino
//
//  Created by Daniel Fortesque on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

class TeslaLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var northDirection: Double = 0
    @Published var longitudine: Double = 0
    @Published var latitudine: Double = 0
    @Published var speed: Double = 0
    
    private var lm: CLLocationManager
    
    override init() {
        self.lm = CLLocationManager()
        super.init()
        
        self.lm.delegate = self
    
        self.lm.requestWhenInUseAuthorization()
        
        self.lm.startUpdatingHeading()
        
        if CLLocationManager.locationServicesEnabled() {
            self.lm.desiredAccuracy = kCLLocationAccuracyBest
            self.lm.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.latitudine = location.coordinate.latitude
        self.longitudine = location.coordinate.longitude
        self.speed = location.speed * 3.6
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.northDirection = newHeading.trueHeading
    }
    
}
