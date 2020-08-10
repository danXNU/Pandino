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
    @EnvironmentObject var mapAgent: MapAgent
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        CarNavigationView()
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
                                        .offset(x: -30, y: 30)
                                        .onTapGesture {
                                            self.widgetAgent.toggle(with: .coordinate)
                                        }
                                        
                                     
                                    }
                                    Spacer()
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    #if !targetEnvironment(macCatalyst)
                                    TopBar()
                                        .environmentObject(self.locationAgent)
                                        .environmentObject(self.widgetAgent)
                                        .environmentObject(self.weatherAgent)
                                        .frame(maxHeight: 45)
                                        .edgesIgnoringSafeArea(.top)
                                    #else
                                    TopBar()
                                        .environmentObject(self.locationAgent)
                                        .environmentObject(self.widgetAgent)
                                        .environmentObject(self.weatherAgent)
                                        .frame(maxHeight: 45)
                                    #endif
                                    Spacer()
                                }
                            }
                        }
                        
                        
                    }
//                    BottomBar()
//                        .frame(maxHeight: 100)
                }
                
                
                
                if self.widgetAgent.isShowingWidget {
                
                    if self.widgetAgent.selectedWidget == .consumi {
                        ConsumiWidgetView()
                            .widgetify(title: WidgetType.consumi.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                            
//                        .environmentObject(self.widgetAgent)
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(maxWidth: geo.size.width * 0.7, maxHeight: geo.size.height * 0.6)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .info {
                        
                            InfoWidget()
                                .widgetify(title: WidgetType.info.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                        
                        
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(maxWidth: geo.size.width * 0.8, maxHeight: geo.size.height * 0.8)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                        
                    } else if self.widgetAgent.selectedWidget == .settings {
                        
                            SettingsWidget().environmentObject(self.weatherAgent)
                                .widgetify(title: WidgetType.settings.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                        
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 1.3)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .coordinate {
                        
                            CoordinateWidget().environmentObject(self.locationAgent).widgetify(title: WidgetType.coordinate.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                        
                        .frame(minWidth: 300, minHeight: 300)
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2.1)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    }
                    else if self.widgetAgent.selectedWidget == .weather {
                        
                            WeatherWidget().environmentObject(self.weatherAgent).widgetify(title: WidgetType.weather.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                        
                        .frame(minWidth: 350, minHeight: 350)
                        .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.6)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    }
                    else if self.widgetAgent.selectedWidget == .music {
                        
                            MusicWidget().widgetify(title: WidgetType.music.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                        
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
