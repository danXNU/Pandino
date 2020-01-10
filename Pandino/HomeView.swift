//
//  HomeView.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var widgetAgent: WidgetAgent
    @EnvironmentObject var locationAgent: TeslaLocationManager
    @EnvironmentObject var weatherAgent: WeatherAgent
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    CarNavigationView().environmentObject(self.widgetAgent).environmentObject(self.locationAgent)
                        .frame(width: geo.size.width / 3)
                    
                    GeometryReader { mapViewSize in
                        ZStack {
                            ShitMap()
                            .edgesIgnoringSafeArea(.all)
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Bussola()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(UIColor.systemBackground))
                                    )
                                    .environmentObject(self.locationAgent)
                                    .frame(maxWidth: 70, maxHeight: 70)
                                    .offset(x: -10, y: 10)
                                    .onTapGesture {
                                        self.widgetAgent.toggle(with: .coordinate)
                                    }
                                    
                                 
                                }
                                Spacer()
                                Spacer()
                            }
                            
                            
                            VStack {
                                TopBar().environmentObject(self.locationAgent).environmentObject(self.widgetAgent).environmentObject(self.weatherAgent)
//                                    .padding()
                                    .frame(maxHeight: 45)//mapViewSize.size.height / 10)
                                    .edgesIgnoringSafeArea(.top)
                                Spacer()
                            }
                        }
                    }
                    
                    
                }
                
                
                if self.widgetAgent.isShowingWidget {
                
                    if self.widgetAgent.selectedWidget == .consumi {
                        Widget(type: .consumi) {
                            ConsumiWidgetView()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(maxWidth: geo.size.width * 0.7, maxHeight: geo.size.height * 0.6)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .info {
                        Widget(type: .info) {
                            InfoWidget()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(maxWidth: geo.size.width * 0.8, maxHeight: geo.size.height * 0.8)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                        
                    } else if self.widgetAgent.selectedWidget == .settings {
                        Widget(type: .settings) {
                            SettingsWidget().environmentObject(self.weatherAgent)
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 1.3)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .fari {
                        Widget(type: .fari) {
                            FariWidget()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2.1)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .coordinate {
                        Widget(type: .coordinate) {
                            CoordinateWidget().environmentObject(self.locationAgent)
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2.1)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    }
                    else if self.widgetAgent.selectedWidget == .weather {
                        Widget(type: .weather) {
                            WeatherWidget().environmentObject(self.weatherAgent)
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 350, minHeight: 350)
                        .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.6)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    }
                    
                    
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
