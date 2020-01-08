//
//  CoordinateWidget.swift
//  Pandino
//
//  Created by Daniel Fortesque on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct CoordinateWidget: View {
    @EnvironmentObject var locationAgent: TeslaLocationManager
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Latitudine")
            Text(String(format: "%.2f", Float(self.locationAgent.latitudine)))  //"\(self.locationAgent.latitudine)")
                .font(.custom("Futura", size: 25))
            
            Spacer()
            
            Text("Longitudine")
            Text(String(format: "%.2f", Float(self.locationAgent.longitudine)))
                .font(.custom("Futura", size: 25))
            
            Spacer()
        }
    }
}

struct CoordinateWidget_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateWidget()
    }
}
