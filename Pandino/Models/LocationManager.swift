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
    
    @Published var animateToUserLocation: Bool = false
    
    public var lm: CLLocationManager
    
    private var isAlreadyAnimated: Bool = false
    
    override init() {
        self.lm = CLLocationManager()
        super.init()
        
        self.lm.delegate = self
    
        self.lm.requestWhenInUseAuthorization()
        self.lm.headingOrientation = .landscapeLeft
        
        self.lm.startUpdatingHeading()
        
        if CLLocationManager.locationServicesEnabled() {
            self.lm.desiredAccuracy = kCLLocationAccuracyBest
            self.lm.startUpdatingLocation()
        }
        
        NotificationCenter.default.addObserver(forName: .remoteSpeedNotification, object: nil, queue: .main) { (notification) in
            if isUsingRemoteNotifications {
                guard let remoteSpeedMessage = notification.object as? GPSMessage else { return }
                self.speed = Double(remoteSpeedMessage.speed)
            }
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("TeslaLocationManager ERROR: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.latitudine = location.coordinate.latitude
        self.longitudine = location.coordinate.longitude
        self.speed = location.speed <= 0 ? 0.0 : location.speed * 3.6
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.northDirection = newHeading.trueHeading
    }
    
}
