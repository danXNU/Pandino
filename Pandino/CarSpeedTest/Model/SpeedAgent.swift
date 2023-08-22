//
//  SpeedAgent.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 29/01/21.
//

import Foundation
import CoreLocation

protocol SpeedAgentDelegate: class {
    func locationChangeCallback(location: CLLocation)
    func errorHandler(error: CLAgentError)
    func authChanged(auth: CLAuthorizationStatus, accuracy: CLAccuracyAuthorization)
    func speedMeasureDidFinish()
    func timerDidStart()
    func timerDidFinish()
    func timerDidTick()
}

class SpeedAgent: NSObject {
    private let manager: CLLocationManager
    
    weak var delegate: SpeedAgentDelegate?
    
    private var timer: Timer?
        
    override init() {
        self.manager = CLLocationManager()
        super.init()
        
        self.manager.delegate = self
    }
    
//    var metricUsed: MetricType {
//        let int = UserDefaults.standard.integer(forKey: DefaultsKeys.metricUsed)
//        return MetricType.init(rawValue: int) ?? .km
//    }
    
    public func requestAccess() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    public func startLocationMonitor() {
        if CLLocationManager.locationServicesEnabled() {
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.startUpdatingLocation()
        }
    }
    
    public func stopLocationMontitor() {
        self.manager.stopUpdatingLocation()
    }
    
    public func start() {
        timer?.invalidate()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (timer) in
                self?.delegate?.timerDidTick()
            })
        }
        delegate?.timerDidStart()
    }
    
    public func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    public func checkAuthStatus() -> (CLAuthorizationStatus, CLAccuracyAuthorization) {
        return (self.manager.authorizationStatus, self.manager.accuracyAuthorization)
    }
    
}

extension SpeedAgent: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        delegate?.locationChangeCallback(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let nsError = error as NSError
        
        if nsError.code == 0 {
            print("Error code 0. Not important...")
            delegate?.errorHandler(error: .notImportant)
        } else if nsError.code == 1 {
            print("Error code 1. Not imporntant")
            delegate?.errorHandler(error: .notImportant)
        } else {
            delegate?.errorHandler(error: .internalError(error))
        }
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = self.checkAuthStatus()
        delegate?.authChanged(auth: status.0, accuracy: status.1)
    }
    
}

