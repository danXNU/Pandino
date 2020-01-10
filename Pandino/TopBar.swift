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
                        LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
//                        Color(UIColor.systemBackground)
                )
                
                   
                HStack {
//                    Bussola()
//                    .environmentObject(self.locationAgent)
//                    .frame(maxWidth: geo.size.width / 8, maxHeight: geo.size.width / 8)
//                    .padding(.vertical)
//                    .onTapGesture {
//                        self.widgetAgent.toggle(with: .coordinate)
//                    }
//                    
//                    Divider()
                    
                    Text("\(Int(self.weatherAgent.temperature))º C")
                        .font(.custom("Futura", size: geo.size.height / 2.5))
                        .onTapGesture {
                            self.widgetAgent.toggle(with: .weather)
                        }
                    Divider()
                    Spacer()
                    
                    Text("Esempio")
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
