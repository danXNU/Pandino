//
//  FariWidget.swift
//  Pandino
//
//  Created by dado on 29/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

//fendinebbia
//abitacolo
//fondo

struct FariWidget: View {
    @EnvironmentObject var wifgetAgent: WidgetAgent
    @EnvironmentObject var ledAgent : LightsManager
    
    var body: some View {
        ZStack {
            if self.ledAgent.isEstablishingConnection {
                Text("Connetto...")
                    .font(Font.custom("Futura", size: 17))
                    .foregroundColor(Color.primary)
            } else if self.ledAgent.isConnected == false {
                Button(action: { self.ledAgent.toggleConnection() }) {
                    Text("Connetti")
                        .font(Font.custom("Futura", size: 25))
                        .foregroundColor(Color.primary)
                }
                .frame(maxWidth: 120)
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(Capsule())
            } else {
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "sun.min")
                            .resizable()
                            .foregroundColor(self.ledAgent.brightnessLevel == 1 ? .yellow : .primary)
                            .frame(width: 40, height: 40)
                            .padding()
                            .onTapGesture {
                                self.ledAgent.chnageBrightness(newValue: 1)
                            }
                        
                        Spacer()
                        
                        Image(systemName: "sun.max")
                            .resizable()
                            .foregroundColor(self.ledAgent.brightnessLevel == 2 ? .yellow : .primary)
                            .frame(width: 45, height: 45)
                        .padding()
                        .onTapGesture {
                            self.ledAgent.chnageBrightness(newValue: 2)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .foregroundColor(self.ledAgent.brightnessLevel == 3 ? .yellow : .primary)
                            .frame(width: 55, height: 55)
                        .padding()
                        .onTapGesture {
                            self.ledAgent.chnageBrightness(newValue: 3)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button(action: { self.ledAgent.toggleLedStatus() }) {
                        Text(self.ledAgent.isPoweredOn ? "Spegni" : "Accendi")
                        .font(Font.custom("Futura", size: 25))
                        .foregroundColor(Color.primary)
                    }
                    .frame(maxWidth: 150)
                    .padding()
                    .background(self.ledAgent.isPoweredOn ? Color.yellow : Color.gray.opacity(0.3))
                    .clipShape(Capsule())
                    .shadow(color: self.ledAgent.isPoweredOn ? Color.yellow : .clear, radius: 10, x: 0, y: 0)
                    
                    Spacer()
                }
            }
                
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(self.ledAgent.isConnected ? .green : .red)
                    Text(self.ledAgent.isConnected ? "Connesso" : "Disconnesso")
                }
                .padding(.trailing, 5)
            }
            .padding(.bottom, 5)
        }
        
    }
}
