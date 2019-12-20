//
//  ContentView.swift
//  Pandino
//
//  Created by Dani Tox on 19/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var tipoSelezionato = 0
    @State var tipi = ["Urbano", "Extraurbano", "Combinato"]
    
    @State var mostraErrore: Bool = false
    
    @State var valoreLitri: Float = 0.0
    @State var kmDiViaggio: Float = 0.0
    
    @State var risultato: Float = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: self.$tipoSelezionato, label: Text("Tipo:")) {
                    ForEach(0..<tipi.count) {
                        Text(self.tipi[$0]).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    Text("Inserirsci il valore in Km di viaggio")
                    Text("\(Int(self.kmDiViaggio)) Km")
                        .offset(x: 0, y: 15)
                    Slider(value: self.$kmDiViaggio, in: 0...500, step: 1)
                }
                .padding(.init(arrayLiteral: [.leading, .trailing]), 20)
                .offset(x: 0, y: 50)
                
                Spacer()
                
                Button(action: calcola) {
                    Text("Calcola")
                }
                
                Text("\(Int(risultato))")
                Spacer()
            }
            .navigationBarTitle("Consumi")
        }
    .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $mostraErrore) { () -> Alert in
            Alert(title: Text("Ecco il risultato"), message: Text("\(Int(risultato))"), dismissButton: Alert.Button.default(Text("Ok")))
        }
        
    }
    
    func calcola() {
        if tipoSelezionato == 0 {
            let consumo1km = 6.6 / 100
            risultato = Float(consumo1km) * kmDiViaggio
        } else {
            
        }
        
        mostraErrore.toggle()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
