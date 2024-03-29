//
//  HomeView.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var widgetAgent: WidgetAgent
    @EnvironmentObject var locationAgent: TeslaLocationManager
    @EnvironmentObject var weatherAgent: WeatherAgent
    @EnvironmentObject var speedWatchAgent: SpeedWatchAgent
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                   span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        CarNavigationView()
                            .frame(width: geo.size.width / 3)
                        
                        MapView()
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                if self.widgetAgent.isShowingWidget {
                    
                    if self.widgetAgent.selectedWidget == .info {
                        
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
                    else if self.widgetAgent.selectedWidget == .timer {
                        
                        TimerWidget(speedWatchAgent: self.speedWatchAgent).widgetify(title: WidgetType.timer.widgetBarTitle, closeAction: self.widgetAgent.closeWidget)
                            
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
