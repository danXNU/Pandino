//
//  CarNavigationView.swift
//  Pandino
//
//  Created by Dani Tox on 25/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct CarNavigationView: View {
    @EnvironmentObject var widgetAgent: WidgetAgent
    @EnvironmentObject var locationAgent: TeslaLocationManager
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Image("tesla-logo")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .accentColor(Color(UIColor.label))
                        .frame(height: 55)
                    
                    Text("CarOS")
                        .font(Font.custom("Futura", size: 65))
                    
                }
                .frame(maxWidth: geo.size.width)
                
                Spacer()
                
                VStack {
                    Text("\(Int(self.locationAgent.speed))")
                        .font(Font.system(size: 60, weight: .bold, design: .default))
                        .foregroundColor(self.locationAgent.speed >= 100 ? Color.red : Color(UIColor.label))
                    
                    Text("Km/h")
                        .font(Font.system(size: 30))
                        .foregroundColor(self.locationAgent.speed >= 100 ? Color.red : Color(UIColor.label))
                }
                
                
                Spacer()
                
                
                BottomBar()
                    .frame(width: geo.size.width, height: 90)
            }
            .padding(.top)
        }
        
    }
}
