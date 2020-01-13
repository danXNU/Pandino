//
//  TopBar.swift
//  Pandino
//
//  Created by Daniel Fortesque on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var locationAgent: TeslaLocationManager
    @EnvironmentObject var widgetAgent: WidgetAgent
    @EnvironmentObject var weatherAgent: WeatherAgent
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("top-bar-color"), .clear]), startPoint: .top, endPoint: .bottom)
//                        Color(UIColor.systemBackground)
                )
                
                   
                HStack {
                    
                    Text("\(Int(self.weatherAgent.temperature))º C")
                        .font(.custom("Futura", size: geo.size.height / 2.5))
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                        .padding()
                    )
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .weather)
                    }
                    
                    Divider()
                    Spacer()
                    
//                    Text("Esempio")
                    Image("tesla-logo")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .accentColor(Color.white)
                    .frame(maxHeight: geo.size.height * 0.8)
                    .offset(x: 0, y: 5)
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .info)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 10)
                
                    
            }
        }.onAppear {
            self.weatherAgent.startScheduling()
        }
        
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
