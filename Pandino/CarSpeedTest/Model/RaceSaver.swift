//
//  RaceSaver.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 08/02/21.
//

import Foundation

struct RaceSaver {
    
    private func dateFormatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func addRace(dataPoints: [DataPoint], speedRange: ClosedRange<Int>, duration: Double) {
        let date = Date()
        let race = RaceObject(name: "Untitled - \(dateFormatted(date: date))",
                              date: date,
                              dataPoints: dataPoints,
                              speedRange: speedRange,
                              duration: duration)
        
        var races : [RaceObject] = getRaces()
        races.append(race)
        self.save(races: races)
    }
    
    func getRaces() -> [RaceObject] {
        let url = FileManager.racesURL
        
        if FileManager.default.fileExists(atPath: url.path) == false {
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let races = try? JSONDecoder().decode([RaceObject].self, from: data) else { return [] }
        
        return races
    }
    
    func save(races: [RaceObject]) {
        do {
            let data = try JSONEncoder().encode(races)
            let url = FileManager.racesURL
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            
            print(url)
        } catch {
            print("\(error)")
        }
    }
}
