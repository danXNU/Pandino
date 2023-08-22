//
//  LightsModel.swift
//  Pandino
//
//  Created by Dani Tox on 25/03/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

class ColorPickerModel: NSObject, ObservableObject {
    @Published var isShowed: Bool = false
    @Published var selectedColor: UIColor = .red
    
    var allColors: [UIColor] = [
        .red, .orange, .yellow, .green, .blue,
        UIColor(red: 180/255, green: 238/255, blue: 180/255, alpha: 1.0),
        .purple, .white
    ]
    
    func getOffset(forIndex index: Int) -> CGSize {
        if !self.isShowed {
            return .zero
        }
        let t = CGFloat(Double.pi * 2) / 8 * CGFloat(index)
        let x = sin(t) * 60 + 0//r = 30, d = 60
        let y = cos(t) * 60 + 0
        return CGSize(width: x, height: y)
    }
}

class LightsManager: NSObject, ObservableObject, CBCentralManagerDelegate {

    public let powerOnDataMessage : Data =  Data.getMessage(withBytes: [0x33, 0x01, 0x01, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x33])
    
    
    public let powerOffDataMessage : Data = Data.getMessage(withBytes: [0x33, 0x01, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x00,
                                                         0x00, 0x00, 0x00, 0x32])
    
    public static let redColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0xff, //done;
        0x00, 0x00, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0xce])
    
    
    public static let orangeColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0xff, //done;
        0x7f, 0x00, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0xb1])
    
    public static let yellowColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0xff, //done;
        0xff, 0x00, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x31])
    
    public static let greenColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0x00, //done;
        0xff, 0x00, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0xce])
    
    public static let blueColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0x00, //done;
        0x00, 0xff, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0xce])
    
    public static let lightBlueColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0x00, //done;
        0xff, 0xff, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x31])
    
    public static let purpleColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0x8b, //done;
        0x00, 0xff, 0x00, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x45])
    
    public static let whiteColor: Data = Data.getMessage(withBytes: [0x33, 0x05, 0x02, 0xff, //done
        0xff, 0xff, 0x01, 0xff,
        0xae, 0x54, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0xcf])
    

    public let mediaLumos : Data = Data.getMessage(withBytes: [
        0x33, 0x04, 0x93, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0xa4
    ])
    
    public let highLumos: Data = Data.getMessage(withBytes: [
        0x33, 0x04, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc8
    ])
    
    public let lowLumos: Data = Data.getMessage(withBytes: [
        0x33, 0x04, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23
    ])

    private var colorMap: [UIColor: Data] = [
        .red : redColor,
        .orange: orangeColor,
        .yellow: yellowColor,
        .green: greenColor,
        .blue: blueColor,
        UIColor(red: 180/255, green: 238/255, blue: 180/255, alpha: 1.0): lightBlueColor,
        .purple: purpleColor,
        .white: whiteColor
    ]
    
    private var centralManager: CBCentralManager!
    private var lighsPeripheral: CBPeripheral!
    
    private var writeCharacteristic: CBCharacteristic?
    private var readCharacteristic: CBCharacteristic?
    private var service: CBService?

    private var timer: Timer?
    
    @Published var isPoweredOn: Bool = false
    @Published var isConnected: Bool = true
    @Published var isEstablishingConnection: Bool = false
    
    @Published var brightnessLevel : Int = 2
    @Published var selectedColor: UIColor = .white
    
    override init() {
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.readCycle()
        })
        
    }
    
    private func readCycle() {
        let writeMessage : Data = Data.getMessage(withBytes: [ 0xaa, 0x01, 0x00, 0x00,
                                                0x00, 0x00, 0x00, 0x00,
                                                0x00, 0x00, 0x00, 0x00,
                                                0x00, 0x00, 0x00, 0x00,
                                                0x00, 0x00, 0x00, 0xab])
        
        if let characteristic = self.readCharacteristic, let periph = self.lighsPeripheral, self.isConnected == true {
            service?.peripheral?.writeValue(writeMessage, for: characteristic, type: .withoutResponse)
            periph.readValue(for: characteristic)
        }
    }
    
    public func write(msgData msg: Data) {
        service?.peripheral?.writeValue(msg, for: writeCharacteristic!, type: .withoutResponse)
    }
    
    public func toggleLedStatus() {
        service?.peripheral?.writeValue(isPoweredOn ? powerOffDataMessage : powerOnDataMessage, for: writeCharacteristic!, type: .withoutResponse)
        
        isPoweredOn.toggle() // per adesso deve essere manuale. In seguito verrà aggiunto un handle per ricevere lo stato dei led direttamente da loro
    }
    
    public func toggleConnection() {
        if isConnected {
            if let ph = self.lighsPeripheral {
               centralManager.cancelPeripheralConnection(ph)
            }
        } else {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            isEstablishingConnection = true
        }
    }
    
    public func setLed(color: UIColor) {
        if let colorMessageData = self.colorMap[color] {
            self.write(msgData: colorMessageData)
        }
    }
    
    public func chnageBrightness(newValue: Int) {
        guard newValue <= 3, newValue >= 1 else { return }
        
        if newValue == 1 {
            self.write(msgData: self.lowLumos)
        } else if newValue == 2 {
            self.write(msgData: self.mediaLumos)
        } else if newValue == 3 {
            self.write(msgData: self.highLumos)
        }
        
        self.brightnessLevel = newValue
        if (1...3).contains(newValue) {
            self.isPoweredOn = true
        } else {
            self.isPoweredOn = false
        }
        
    }
    
    public func increaseBrightness() {
        chnageBrightness(newValue: self.brightnessLevel + 1)
    }
    
    public func decreaseBrightness() {
        chnageBrightness(newValue: self.brightnessLevel - 1)
    }
}

extension LightsManager {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            //      centralManager.scanForPeripherals(withServices: nil, options: nil)
        @unknown default:
            print("Bah")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        if peripheral.name == "ihoment_H6113_F617" {
            lighsPeripheral = peripheral
            lighsPeripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(lighsPeripheral)
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        //    let uuid = CBUUID(string: "FFE0")
        //    heartRatePeripheral.discoverServices([uuid])
        isConnected.toggle()
        isEstablishingConnection = false
        lighsPeripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Peripheral did Disconnect! \(String(describing: error))")
        self.isConnected = false
        self.lighsPeripheral = nil
    }
}

extension LightsManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("ERROR: \(error)")
            return
        }
        
        guard let services = peripheral.services else { print("No services"); return }
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            //      print(characteristic)
            
            if characteristic.properties.contains(.read) {
                print("SERVICE: \(service.uuid) -- \(characteristic.uuid): properties contains .read")
                //        peripheral.readValue(for: characteristic)
                if service.uuid.uuidString == "00010203-0405-0607-0809-0A0B0C0D1910" &&
                    characteristic.uuid.uuidString == "00010203-0405-0607-0809-0A0B0C0D2B11" {
                    readCharacteristic = characteristic
                }
            }
            if characteristic.properties.contains(.notify) {
                print("SERVICE: \(service.uuid) -- \(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            if characteristic.uuid.uuidString == "00010203-0405-0607-0809-0A0B0C0D2B11" {
                writeCharacteristic = characteristic
                self.service = writeCharacteristic!.service
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        switch characteristic.uuid {
//        case writeC:
//            if let data = characteristic.value {
//                if data.count == 0x14 {
//                    print("NOTIFICATION_BLE_RECEIVED_SUCCESS")
//                }
//            } else {
//                print("No data!")
//            }
//
//        case notificatonC:
//            guard let data = characteristic.value else { print("Fuck. No data"); return }
//            var dataStr = ""
//            for byte in data {
//                dataStr.append("\(byte) ")
//            }
//            print("Data count: \(data.count). RAW: \(dataStr))")
//
//        default:
//            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
//        }
    }

}
