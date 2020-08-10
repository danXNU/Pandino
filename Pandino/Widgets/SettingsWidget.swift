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
    
    @AppStorage("weatherUpdateTime") var weatherTimer: Double = 60
    
    var body: some View {
        Form {
            Section(header: Text("Meteo")) {
                HStack {
                    Stepper(value: $weatherTimer, in: 1.0 ... 60.0) {
                        Text("Secondi di aggiornamento del meteo")
                            .font(.custom("Futura", size: 25))
                    }
                    Text("\(weatherTimer)")
                    .font(.custom("Futura", size: 20))
                }
                .frame(minHeight: 60)
            }
        }
        .onChange(of: weatherTimer) { (_) in
            self.weatherAgent.changeTimerDuration(seconds: weatherTimer)
        }
    }
}

struct SettingsWidget_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWidget()
    }
}
