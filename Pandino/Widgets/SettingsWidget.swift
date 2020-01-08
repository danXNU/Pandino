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
    
    var body: some View {
        Form {
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
    }
}

struct SettingsWidget_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWidget()
    }
}
