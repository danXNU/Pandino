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
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
                .edgesIgnoringSafeArea(.all)
                
            
            VStack {
                Text("T-Pandino")
                    .font(Font.custom("Futura", size: 65))
                    //.font(Font.system(size: 65, weight: Font.Weight.medium, design: .default))
                
                Spacer()
                
                VStack {
                    Text("0")
                        .font(Font.system(size: 60, weight: .bold, design: .default))
                    
                    Text("Km/h")
                        .font(Font.system(size: 30))
                }
                
//                Spacer()
                Image("fiat-panda")
                    .resizable()
                    .frame(width: 400, height: 300)
                
                Spacer()
                
                Button(action: { self.widgetAgent.toggle(with: .consumi) }) {
                    Text("Consumi")
                        .font(Font.custom("Futura", size: 25))
                        .foregroundColor(Color.primary)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(Capsule())
                
                Spacer()
                
                HStack {
                    Image(systemName: "gear")
                    .resizable()
                    .foregroundColor(Color.gray.opacity(1.0))
                    .frame(width: 50, height: 50)
                    .offset(x: 20, y: 0)
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .settings)
                    }
                    
                    
                    Spacer()
                    
                    Image(systemName: "tv.music.note")
                    .resizable()
                    .foregroundColor(Color.gray.opacity(1.0))
                    .frame(width: 50, height: 50)
                    .offset(x: 0, y: 0)
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .info)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "info.circle")
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 50, height: 50)
                    .offset(x: -20, y: 0)
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .info)
                    }
                }
                
                
            }
        }
    }
}
