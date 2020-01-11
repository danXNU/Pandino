//
//  WeatherAgent.swift
//  Pandino
//
//  Created by Dani Tox on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import SwiftUI
import DXNetworkManager

var weatherUpdateTime: Double {
    get {
        return UserDefaults.standard.double(forKey: "weatherUpdateTime")
    } set {
        UserDefaults.standard.set(newValue, forKey: "weatherUpdateTime")
    }
}


class WeatherAgent: ObservableObject {
    private let apiKey = "9bf018ec677f60afe839ae0b26f74721"
    
    public var locationManager: TeslaLocationManager?
    private var timerScheduler: Timer?
    
    public var errString: String = ""
    @Published var timerDurationPublicValue: Int = Int(weatherUpdateTime) {
        didSet {
            self.changeTimerDuration(seconds: Double(timerDurationPublicValue))
        }
    }
    
    @Published var temperature: Double = 0
    @Published var temperaturaPercepita: Double = 0
    @Published var pressione: Int = 0
    @Published var humidity: Int = 0
    
    
    private func changeTimerDuration(seconds: Double) {
        weatherUpdateTime = seconds
        print("Changed weather timer duration. Resetto il timer")
        self.stop()
        self.startScheduling()
    }
    
    public func fetchData(latitudine: Double, longitudine: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitudine)&lon=\(longitudine)&appid=\(apiKey)"
        let request = DirectRequest(urlString: urlString)
        let agent = NetworkAgent<CurrentLocalWeather>()
        agent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.temperature = weather.main.celsiusTemp
                    self.temperaturaPercepita = weather.main.celsiusPercepita
                    self.pressione = weather.main.pressure
                    self.humidity = weather.main.humidity
                }
            case .failure(let err):
                self.errString = "\(err)"
                print("\(err)")
            }
        }
        
        print("Executed weather fetch")
    }
    
    public func startScheduling() {
        guard let manager = self.locationManager else { fatalError("No location manager when starting the scheduling timer") }
        if weatherUpdateTime <= 0 { weatherUpdateTime = 5 }
        
        self.timerScheduler = Timer.scheduledTimer(withTimeInterval: weatherUpdateTime, repeats: true, block: { [weak self] (timer) in
            self?.fetchData(latitudine: manager.latitudine, longitudine: manager.longitudine)
        })
        //self.timerScheduler?.fire()
    }
    
    public func stop() {
        self.timerScheduler?.invalidate()
        self.timerScheduler = nil
    }
    
}

struct CurrentLocalWeather: Decodable {
    let base: String?
    let clouds: Clouds
    let cod: Int?
    let coord: Coord
    let dt: Int?
    let id: Int?
    let main: Main
    let name: String?
    let sys: Sys?
    let visibility: Int?
    let weather: [Weather]
    let wind: Wind
}
struct Clouds: Decodable {
    let all: Int?
}
struct Coord: Decodable {
    let lat: Double
    let lon: Double
}
struct Main: Decodable {
    let humidity: Int
    let pressure: Int
    let temp: Double
    let temp_feels: Double
    let tempMax: Double
    let tempMin: Double
    private enum CodingKeys: String, CodingKey {
        case humidity, pressure, temp, tempMax = "temp_max", tempMin = "temp_min", temp_feels = "feels_like"
    }
    
    var celsiusTemp: Double {
        let kelvinTemp = Measurement.init(value: self.temp, unit: UnitTemperature.kelvin)
        return kelvinTemp.converted(to: .celsius).value
    }
    
    var celsiusPercepita: Double {
        let kelvin = Measurement.init(value: self.temp_feels, unit: UnitTemperature.kelvin)
        return kelvin.converted(to: .celsius).value
    }
}
struct Sys: Decodable {
    let country: String?
    let id: Int?
//    let message: Double
    let sunrise: UInt64
    let sunset: UInt64
    let type: Int?
}
struct Weather: Decodable {
    let description: String?
    let icon: String?
    let id: Int?
    let main: String?
}
struct Wind: Decodable {
//    let deg: Int
    let speed: Double?
}
