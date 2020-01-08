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
    @State var areFariAccesi: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .edgesIgnoringSafeArea(.all)
                            
                        
                        VStack {
                            HStack {
                                Image("tesla-logo")
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .accentColor(Color(UIColor.label))
                                    .frame(height: 55)
                                
                                Text("Pandino")
                                .font(Font.custom("Futura", size: 65))
                                    
                            }
                            .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                            
                            Spacer()
                            
                            VStack {
//                                Text("\(Int(self.locationAgent.speed))")
                                Text("\(Int(self.locationAgent.speed))")
                                    .font(Font.system(size: 60, weight: .bold, design: .default))
                                
                                Text("Km/h")
                                    .font(Font.system(size: 30))
                            }
                            
            //                Spacer()
                            Image("fiat-panda")
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fit)
                                .frame(width: geo.size.width - 30)//, height: 300)
                            
                            Spacer()
                            
                            
                            HStack {
                                Spacer()
                                
                                Button(action: { self.widgetAgent.toggle(with: .consumi) }) {
                                    Text("Consumi")
                                        .font(Font.custom("Futura", size: 25))
                                        .foregroundColor(Color.primary)
                                }
                                .frame(maxWidth: 120)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .clipShape(Capsule())
                                
                                Spacer()
                                
                                Button(action: { self.widgetAgent.toggle(with: .fari) }) {
                                    Text("Fari")
                                        .font(Font.custom("Futura", size: 25))
                                        .foregroundColor(Color.primary)
                                }
                                .frame(maxWidth: 120)
                                .padding()
                                .background(self.areFariAccesi ? .yellow : Color.gray.opacity(0.3))
                                .clipShape(Capsule())
                                .shadow(color: self.areFariAccesi ? .yellow : .clear, radius: self.areFariAccesi ? 10 : 0)
                                
                                Spacer()
                            }
                            .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                            
                            
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
                            .offset(x: 0, y: -10)
                            
                            
                        }
                    }
        }
        
    }
}
