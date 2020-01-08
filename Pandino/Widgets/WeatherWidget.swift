//
//  WeatherWidget.swift
//  Pandino
//
//  Created by Dani Tox on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct WeatherWidget: View {
    @EnvironmentObject var weatherAgent: WeatherAgent
    
    var body: some View {
        Form {
            HStack {
                Text("Temperatura attuale").font(.custom("Futura", size: 25))
                Spacer()
                Text("\(Int(self.weatherAgent.temperature))º C").font(.custom("Futura", size: 25))
            }
            .frame(minHeight: 60)
            
            HStack {
                Text("Temperatura percepita").font(.custom("Futura", size: 25))
                Spacer()
                Text("\(Int(self.weatherAgent.temperaturaPercepita))º C").font(.custom("Futura", size: 25))
            }
            .frame(minHeight: 60)
            
            HStack {
                Text("Pressione").font(.custom("Futura", size: 25))
                Spacer()
                Text("\(Int(self.weatherAgent.pressione)) hPa").font(.custom("Futura", size: 25))
            }
            .frame(minHeight: 60)
            
            HStack {
                Text("Umidità").font(.custom("Futura", size: 25))
                Spacer()
                Text("\(Int(self.weatherAgent.humidity))%").font(.custom("Futura", size: 25))
            }
            .frame(minHeight: 60)
                
        }
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget()
    }
}
