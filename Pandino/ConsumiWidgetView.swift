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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white)
                .shadow(radius: 20)
//
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Inserisci il tipo di guida")
                    Picker(selection: self.$tipoSelezionato, label: Text("Tipo:")) {
                        ForEach(0..<tipi.count) {
                            Text(self.tipi[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Inserirsci il valore in Km di viaggio")
                    Text("\(Int(self.kmDiViaggio)) Km")
                        .offset(x: 0, y: 15)
                    Slider(value: self.$kmDiViaggio, in: 0...500, step: 1)
                }
                .padding(.init(arrayLiteral: [.leading, .trailing]), 20)
                
                Spacer()
                Text(String(format: "%.1f", calcola()))
                    .font(Font.largeTitle)
                    
                Spacer()
            }
            
        }
        
    }
    
    func calcola() -> Float {
        if tipoSelezionato == 0 {
            let consumo1km = 6.6 / 100
            return Float(consumo1km) * kmDiViaggio
        } else {
            return 0.0
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumiWidgetView()
    }
}
