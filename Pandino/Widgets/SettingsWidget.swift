//
//  SettingsWidget.swift
//  Pandino
//
//  Created by Dani Tox on 26/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct SettingsWidget: View {
    @EnvironmentObject var weatherAgent: WeatherAgent
    
    @State var isUsingDeviceGPS: Bool = false
    @State var remoteDeviceIP: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meteo")) {
                HStack {
                    Stepper(value: $weatherAgent.timerDurationPublicValue, in: 1 ... 60) {
                        Text("Secondi di aggiornamento del meteo")
                            .font(.custom("Futura", size: 25))
                    }
                    Text("\(self.weatherAgent.timerDurationPublicValue)")
                    .font(.custom("Futura", size: 20))
                }
                .frame(minHeight: 60)
            }
            
            Section(header: Text("Contachilometri")) {
                Toggle(isOn: $isUsingDeviceGPS, label: { Text("Usa il GPS di un dispositivo esterno").font(.custom("Futura", size: 25)) })
                .frame(minHeight: 60)
                if isUsingDeviceGPS {
                    HStack {
                        Text("IP del dispositivo remoto").font(.custom("Futura", size: 25))
                        Spacer()
                        TextField("Indirizzo IP", text: $remoteDeviceIP)
                            .frame(width: 200)
                    }.frame(minHeight: 60)
                }
                
            }
            
            Button(action: save) { Text("Salva impostazioni") }
            
        }
        .onAppear {
            self.isUsingDeviceGPS = isUsingRemoteNotifications
            self.remoteDeviceIP = remoteIPforSpeed
        }
    }
    
    func save() {
        let savedIP = remoteIPforSpeed
        
        isUsingRemoteNotifications = self.isUsingDeviceGPS
        remoteIPforSpeed = self.remoteDeviceIP
        
        if savedIP != remoteIPforSpeed {
            NotificationCenter.default.post(name: .remoteDeviceIPChanged, object: nil)
        }
    }
}

struct SettingsWidget_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWidget()
    }
}
