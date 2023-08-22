//
//  SpeedViewModel.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 29/01/21.
//

import Foundation
import CoreLocation

class SpeedViewModel: ObservableObject {
    
    @Published var speed: Measurement<UnitSpeed> = .init(value: 0, unit: .milesPerHour)
    @Published var authState: AuthState = .initial {
        didSet {
            if authState == .notDetermined {
                self.agent.requestAccess()
            } else if authState == .available {
                self.agent.startLocationMonitor()
            }
        }
    }
            
    @Published var isShowingError: Bool = false
    public var errorMsg: String = ""
    
    @Published var startTime: TimeInterval = 0
    @Published var endTime: TimeInterval = 0
    
    public var duration: TimeInterval {
        endTime - startTime
    }
    
    @Published var elapsedTime: TimeInterval = 0

    private let agent: SpeedAgent = SpeedAgent()
    var speedRange: ClosedRange<Int> = 0...60
    
    @Published var dataPoints: [DataPoint] = []

    @Published var viewState: ViewState = .normal {
        didSet {
            switch viewState {
            case .waitingStart:
                self.startTime = 0
                self.endTime = 0
                self.elapsedTime = 0
                if self.speed.value > Double(self.speedRange.lowerBound) {
                    self.viewState = .error(.speedGreaterThanMin)
                }
            case .running:
                self.startTime = Date.timeIntervalSinceReferenceDate
                self.endTime = 0
                self.agent.start()
            case .finished:
                self.endTime = Date.timeIntervalSinceReferenceDate
                self.agent.stopTimer()
            case .error(_):
                self.agent.stopTimer()
            case .normal:
                if dataPoints.isEmpty == false {
                    let model = RaceSaver()
                    model.addRace(dataPoints: self.dataPoints, speedRange: self.speedRange, duration: self.elapsedTime)
                }                
                
                self.dataPoints.removeAll(keepingCapacity: true)
                self.elapsedTime = 0
            }
        }
    }
    
    init() {
        agent.delegate = self
        
        self.checkStatus()
    }
    
    func checkStatus() {
        let status : (auth: CLAuthorizationStatus, accuracy: CLAccuracyAuthorization) = agent.checkAuthStatus()
        
        switch status.auth {
        case .authorizedWhenInUse, .authorizedAlways:
            if status.accuracy == .fullAccuracy {
                print("Authorized!")
                self.authState =  .available
            } else {
                print("It's authorized, but with reduced accuracy...")
                self.authState = .reducedAccuracy
            }
        case .notDetermined:
            print("Send auth request")
            self.authState = .notDetermined
        default:
            print("Denied auth")
            self.authState = .notAvailable
        }
    }
    
    public func prepareToStart() {
//        self.checkStatus()
        
        switch self.authState {
        case .available:
            start()
        case .reducedAccuracy:
            self.viewState = .error(.reducedLocatonAccuracy)
        case .notAvailable:
            self.viewState = .error(.declinedLocationAccess)
        default:
            print("strange state")
        }
    }
    
    private func showError(msg: String) {
        self.errorMsg = msg
        self.isShowingError = true
        
        self.viewState = .error(.string(msg))
    }
    
    private func start() {
        self.viewState = .waitingStart
    }
    
    public func cancel() {
        self.viewState = .finished
    }
    
    public func reset() {
        self.viewState = .normal
    }
    
    
}

//MARK: - SpeedAgentDelegate
extension SpeedViewModel: SpeedAgentDelegate {
    
    var metricUsed: MetricType {
        let int = UserDefaults.standard.integer(forKey: DefaultsKeys.metricUsed)
        return MetricType.init(rawValue: int) ?? .km
    }

    func locationChangeCallback(location: CLLocation) {
        var speed = Measurement<UnitSpeed>.init(value: location.speed <= 0 ? 0.0 : location.speed, unit: .metersPerSecond)
        
        if metricUsed == .km {
            speed = speed.converted(to: .kilometersPerHour)
        } else {
            speed = speed.converted(to: .milesPerHour)
        }
        
        DispatchQueue.main.async {
            self.speed = speed
            print("New speed: \(speed.value)")
            
            switch self.viewState {
            case .waitingStart:
                if speed.value > Double(self.speedRange.lowerBound) {
                    self.viewState = .running
                }
            case .running:
                let maxSpeed = Double(self.speedRange.upperBound)
                if speed.value >= maxSpeed {
                    self.viewState = .finished
                }
                
                let newPoint = DataPoint(timeOffset: self.elapsedTime, value: speed, location: .init(location: location))
                self.dataPoints.append(newPoint)
            case .error(let err):
                if err == .speedGreaterThanMin {
                    if speed.value == 0 {
                        self.viewState = .waitingStart
                    }
                }
            default: break
            }
            
            
        }
    }
    
    func errorHandler(error: CLAgentError) {
        print("ERROR HANDLER: error: \(error)")
        var errorStr: String = ""
        
        switch error {
        case .deniedAccess:
            print("Error: .deniedAccess")
        case .internalError(let error):
            errorStr = "\(error)"
            DispatchQueue.main.async {
                self.showError(msg: errorStr)
            }
        case .notImportant:
            print("error returned is not important...")
        }
    }
    
    func authChanged(auth: CLAuthorizationStatus, accuracy: CLAccuracyAuthorization) {
        print("Auth changed: \(auth.stringValue), \(accuracy.stringValue)")
        
        DispatchQueue.main.async {
            self.checkStatus()
        }
    }
    
    func speedMeasureDidFinish() {
        
    }
    
    func timerDidStart() {
        DispatchQueue.main.async {
            print("Timer did start")
        }
    }
    
    
    func timerDidFinish() {
        DispatchQueue.main.async {
            print("Timer did finish")
        }
    }
    
    func timerDidTick() {
        DispatchQueue.main.async {
            print("Timer did tick - time passed")
            self.elapsedTime += 0.1
        }
    }
}

//MARK:- Helper types
extension SpeedViewModel {
    enum AuthState {
        case initial
        case available
        case reducedAccuracy
        case notAvailable
        case notDetermined
    }


    enum ViewState: Identifiable, Equatable {
        case normal
        case finished
        case error(SpeedError)
        case running
        case waitingStart
        
        var id: String {
            String(describing: self)
        }
        
        static func == (lhs: ViewState, rhs: ViewState) -> Bool {
            return lhs.id == rhs.id
        }
    }
}
