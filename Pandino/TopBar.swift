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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemBackground))
                
                   
                HStack {
                    Bussola()
                    .environmentObject(self.locationAgent)
                    .frame(maxWidth: geo.size.width / 8, maxHeight: geo.size.width / 8)
                    .padding(.vertical)
                    .onTapGesture {
                        self.widgetAgent.toggle(with: .coordinate)
                    }
                    
                    Divider()
                    Spacer()
                    
                    Text("Esempio")
                    Spacer()
                }
                .padding(.leading, 10)
                
                    
            }
        }
        
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
