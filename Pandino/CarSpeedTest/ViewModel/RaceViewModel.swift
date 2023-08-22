//
//  RaceViewModel.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 09/02/21.
//

import Foundation

class RaceViewModel: ObservableObject {
    
    private let agent = RaceSaver()
    
    @Published var races: [RaceObject] = []
    
    func fetchRaces() {
        self.races = agent.getRaces().sorted(by: { $0.date > $1.date })
    }
    
    func remove(race: RaceObject) {
        self.races.removeAll(where: { $0 == race })
    }
    
    func saveRaces() {
        agent.save(races: self.races)
    }
}
