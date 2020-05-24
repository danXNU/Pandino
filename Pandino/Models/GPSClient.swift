//
//  GPSClient.swift
//  Pandino
//
//  Created by Dani Tox on 23/05/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import Network

class GPSClient {
    
    var connection: NWConnection?
    var isConnected: Bool = false
    
    init() {
        initializeConnection()
    }
    
    func initializeConnection() {
        self.connection = NWConnection(host: .init("192.168.1.230"), port: 2905, using: .tcp)
        self.connection?.stateUpdateHandler = { state in
            switch state {
            case .failed(let err):
                print("Error connection: \(err)")
                self.isConnected = false
            case .ready:
                print("Ready")
                self.isConnected = true
            default:
                print("Connection state changed: \(state)")
                self.isConnected = false
            }
        }
        
        self.connection?.receive(minimumIncompleteLength: 1, maximumLength: 1024, completion: { (data, context, isComplete, error) in
            if error != nil { print("Message reception error: \(error!)"); return }
            print("Message isComplete: \(isComplete)")
            guard let data = data else {
                print("Received no data")
                return
            }
            
            guard let receivedSpeedMessage = try? JSONDecoder().decode(GPSMessage.self, from: data) else {
                print("Error decoding received message")
                return
            }
            
            
            NotificationCenter.default.post(name: .remoteSpeedNotification, object: receivedSpeedMessage)
        })
        
        self.connection?.start(queue: DispatchQueue.global(qos: .utility))
    }
    
}

struct GPSMessage: Codable {
    enum MessageType: Int, Codable {
        case speedData = 1
    }
    var id: UUID
    var type: MessageType
    var speed: Float
    var serverVersion: Int
}
