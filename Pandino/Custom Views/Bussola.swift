//
//  Bussola.swift
//  Pandino
//
//  Created by Daniel Fortesque on 08/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct Bussola: View {
    
    @EnvironmentObject var locationManager : TeslaLocationManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("N")
                    .font(Font.custom("Futura", size: 15))
//                        .padding(.top, 5)
                    
                    Spacer()
                    
                    HStack {
                        Text("O")
                            .font(Font.custom("Futura", size: 15))
                            .padding(.leading, 5)
                        Spacer()
                        
                        Text("E")
                            .font(Font.custom("Futura", size: 15))
                            .padding(.trailing, 5)
                    }
                    .padding(.horizontal, 0)
                    
                    Spacer()
                    
                    Text("S")
                    .font(Font.custom("Futura", size: 15))
//                    .padding(.bottom, 5)
                }
//                .padding(.all, 5)
//                .background(
////                    Circle()
////                        .stroke(Color(UIColor.label), lineWidth: 1)
//                )
                
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .foregroundColor(Color.red)
                    .scaleEffect(0.27)
                    .rotationEffect(Angle(degrees: self.locationManager.northDirection))
                
            }
        }
        
        
    }
}

struct Bussola_Previews: PreviewProvider {
    static var previews: some View {
        Bussola()
    }
}
