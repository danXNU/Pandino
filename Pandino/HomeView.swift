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
                            MapView()
                            .edgesIgnoringSafeArea(.all)
                            
                            VStack {
                                TopBar().environmentObject(self.locationAgent).environmentObject(self.widgetAgent).environmentObject(self.weatherAgent)
                                    .padding()
                                    .frame(maxHeight: mapViewSize.size.height / 7)
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
                        .frame(maxWidth: geo.size.width * 0.7, maxHeight: geo.size.height * 0.7)
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
