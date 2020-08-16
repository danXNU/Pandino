//
//  SpeedWatchAgent.swift
//  Pandino
//
//  Created by Dani Tox on 15/08/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import Combine

class SpeedWatchAgent: ObservableObject {
    
    enum State {
        case settings
        case running
        case finished
    }
    
    private var locationManager: TeslaLocationManager
    private var observers: [AnyCancellable] = []
    
    @Published var state: State = .settings
    @Published var timeElapsed: Double = 0.0
    @Published var currentSpeed: Measurement<UnitSpeed> = .init(value: 0, unit: .milesPerHour)
    
    private var minSpeed: Measurement<UnitSpeed> = .init(value: 0, unit: UnitSpeed.milesPerHour)
    private var maxSpeed: Measurement<UnitSpeed> = .init(value: 0, unit: UnitSpeed.milesPerHour)
    
    private var timer: Timer?
    
    init(locationManager: TeslaLocationManager) {
        self.locationManager = locationManager
        
        let speedSub = self.locationManager.$speed
            .receive(on: RunLoop.main)
            .assign(to: \SpeedWatchAgent.currentSpeed, on: self)
        self.observers.append(speedSub)
    }
    
    public func start(minSpeed: Double, maxSpeed: Double) {
        self.state = .running
        
        self.minSpeed = .init(value: minSpeed, unit: .milesPerHour)
        self.maxSpeed = .init(value: maxSpeed, unit: .milesPerHour)
        
        resetTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            if self.currentSpeed.value > self.minSpeed.value && self.currentSpeed.value < self.maxSpeed.value && self.state == .running {
                self.timeElapsed += 0.1
                return
            }
            if self.currentSpeed.value >= self.maxSpeed.value {
                self.state = .finished
                self.resetTimer()
            }
        })
    }
    
    
    private func resetTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}
