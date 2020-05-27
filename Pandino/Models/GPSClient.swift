//
//  GPSClient.swift
//  Pandino
//
//  Created by Dani Tox on 23/05/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import Network

class GPSClient: ObservableObject {
    
    var connection: NWConnection?
    @Published var isConnected: Bool = false
    
    init() {
        if isUsingRemoteNotifications {
            initializeConnection()
        }
        
        setupObservers()
    }
    
    func initializeConnection(remoteIP: String = remoteIPforSpeed) {
        print("Starting connection to remote device...")
        self.connection = NWConnection(host: .init(remoteIP), port: 2905, using: .tcp)
        self.connection?.stateUpdateHandler = { state in
            switch state {
            case .failed(let err):
                print("Error connection: \(err)")
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            case .ready:
                print("Connection to remote device established successfully")
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            default:
                print("Connection state changed: \(state)")
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
        receiveMessage()
        
        self.connection?.start(queue: DispatchQueue.global(qos: .utility))
    }
    
    func receiveMessage() {
        self.connection?.receive(minimumIncompleteLength: 1, maximumLength: 65536, completion: { (data, context, isComplete, error) in
            if error != nil { print("Message reception error: \(error!)"); return }
            print("Message isComplete: \(isComplete)")
            guard let data = data else {
                print("Received no data")
                return
            }
            
            guard let receivedSpeedMessage = try? JSONDecoder().decode(GPSMessage.self, from: data) else {
                print("Error decoding received message")
                print("RAW MESSAGE: \(String(data: data, encoding: .utf8) ?? "NULL")")
                self.receiveMessage()
                return
            }
            
            
            NotificationCenter.default.post(name: .remoteSpeedNotification, object: receivedSpeedMessage)
            self.receiveMessage()
        })
    }
    
    func stopConnection() {
        self.isConnected = false
        self.connection?.cancel()
        self.connection = nil
        print("Stopped connection to remote device IP")
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: .remoteDeviceIPChanged, object: nil, queue: .main) { (notification) in
            print("Received notification for changes to remote device IP")
            self.stopConnection()
            self.initializeConnection()
        }
        
        NotificationCenter.default.addObserver(forName: .remoteDeviceIsUsedPreferenceChanged, object: nil, queue: .main) { (notification) in
            if isUsingRemoteNotifications {
                self.initializeConnection()
            } else {
                self.stopConnection()
            }
        }
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
