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
    
//    @Binding var isShowing: Bool
    
    @State var dragAmount: CGSize = .zero
    
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
                Text(String(format: "%.1f litri", calcola()))
                    .font(Font.largeTitle)
                
                Spacer()
            }
            
            // X button
//            CloseButton {
//                self.isShowing.toggle()
//            }

        }
//        .offset(x: 0, y: dragAmount.height)
//        .gesture(
//            DragGesture()
//                .onChanged { self.dragAmount = $0.translation }
//                .onEnded { value in
//                    if abs(self.dragAmount.height) > 300 {
//                        withAnimation {
//                            if self.dragAmount.height > 0 {
//                                self.dragAmount = CGSize(width: 0, height: 1000)
//                            } else {
//                                self.dragAmount = CGSize(width: 0, height: -1000)
//                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { self.isShowing.toggle() })
//                        }
//                    } else {
//                        self.dragAmount = .zero
//                    }
//            }
//        )
            .animation(.spring())
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
