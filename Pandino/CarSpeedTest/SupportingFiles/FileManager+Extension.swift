//
//  FileManager+Extension.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 09/02/21.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first!
    }
    
    static var racesURL: URL {
        return FileManager.documentDirectory.appendingPathComponent("races.json")        
    }
}
