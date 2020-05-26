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
    @ObservedObject var colorsModel: ColorPickerModel = ColorPickerModel()
    
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
                    
                    HStack {
                    
                        Spacer()
                        
                        ZStack {
                            
                            Color(self.colorsModel.selectedColor)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .onTapGesture {
                                    withAnimation {
                                        self.colorsModel.isShowed.toggle()
                                    }
                            }
                            
                            ForEach(0 ..< self.colorsModel.allColors.count, id: \.self) { index in
                                Color(self.colorsModel.allColors[index])
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .offset(self.colorsModel.getOffset(forIndex: index))
                                    .opacity(self.colorsModel.isShowed ? 1 : 0)
                                    .onTapGesture {
                                        withAnimation {
                                            self.colorsModel.selectedColor = self.colorsModel.allColors[index]
                                            self.colorsModel.isShowed.toggle()
                                            self.ledAgent.setLed(color: self.colorsModel.selectedColor)
                                        }
                                }
                            }
                            
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
                        Color.black
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        Spacer()
                    }
                    
                    
                    
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

struct FariWidget_Previews: PreviewProvider {
    static var previews: some View {
        let widget = WidgetAgent()
        let led = LightsManager()
        led.isConnected = true
        return ZStack {
                Color.black
                
            FariWidget().environmentObject(widget).environmentObject(led).environment(\.colorScheme, .dark)
        }
    }
}
