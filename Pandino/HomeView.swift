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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    CarNavigationView().environmentObject(self.widgetAgent)
                        .frame(width: geo.size.width / 3)
                    
                    //Map View
                    MapView()
                        .edgesIgnoringSafeArea(.all)
                }
                
                
                if self.widgetAgent.isShowingWidget {
                
                    if self.widgetAgent.selectedWidget == .consumi {
                        Widget(type: .consumi) {
                            ConsumiWidgetView()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(width: 500, height: 500)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .info {
                        Widget(type: .info) {
                            InfoWidget()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(width: 500, height: 500)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                        
                    } else if self.widgetAgent.selectedWidget == .settings {
                        Widget(type: .settings) {
                            SettingsWidget()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 1.3)
                        .offset(x: 0, y: self.widgetAgent.widgetOffset.height)
                        .animation(.easeIn)
                    } else if self.widgetAgent.selectedWidget == .fari {
                        Widget(type: .fari) {
                            FariWidget()
                        }
                        .environmentObject(self.widgetAgent)
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 1.3)
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
