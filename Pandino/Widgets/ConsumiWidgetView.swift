//
//  ContentView.swift
//  Pandino
//
//  Created by Dani Tox on 19/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct ConsumiWidgetView: View {
    @State var tipoSelezionato = 0
    @State var tipi = ["Urbano", "Extraurbano", "Combinato"]
    
    @State var valoreLitri: Float = 0.0
    @State var kmDiViaggio: Float = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
            //            Spacer()
                        
                        VStack {
                            Text("Inserisci il tipo di guida")
                                .font(.custom("Futura", size: 25))
                            
                            Picker(selection: self.$tipoSelezionato, label: Text("Tipo:").font(.custom("Futura", size: 20))) {
                                ForEach(0..<tipi.count) {
                                    Text(self.tipi[$0]).tag($0)
                                        .font(.custom("Futura", size: 20))
                                    
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        
                        Spacer()
                        
                        VStack {
                            Text("Inserirsci il valore in Km di viaggio").font(.custom("Futura", size: 20))
                            Text("\(Int(self.kmDiViaggio)) Km").font(.custom("Futura", size: 40))
                                .offset(x: 0, y: 15)
                            Slider(value: self.$kmDiViaggio, in: 0...500, step: 1)
                        }
                        .padding(.init(arrayLiteral: [.leading, .trailing]), 20)
                        
                        Spacer()
                        Text(String(format: "%.1f litri", calcola()))
                            .font(.custom("Futura", size: 60))
                        
                        Spacer()
                    }
        }
        
        
        
    }
    
    func calcola() -> Float {
        if tipoSelezionato == 0 {
            let consumo1km = 6.6 / 100
            return Float(consumo1km) * kmDiViaggio
        } else if tipoSelezionato == 1 {
            let consumo1km = 8.8 / 100
            return Float(consumo1km) * kmDiViaggio
        } else {
            let consumo1km = 8.4 / 100
            return Float(consumo1km) * kmDiViaggio
        }
    
    }
    
}
