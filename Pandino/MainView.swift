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
    
    @State var raggio : CGFloat = 100
    @State var isPressed: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: self.$tipoSelezionato, label: Text("Tipo:")) {
                    ForEach(0..<tipi.count) {
                        Text(self.tipi[$0]).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                Circle()
                .frame(width: raggio / 2, height: raggio / 2)
                .foregroundColor(Color.red)
                .onTapGesture {
                    self.isPressed.toggle()
                    withAnimation(Animation.spring()) {
                        self.calcola()
                    }
                }
                
                
                Spacer()
            }
            .navigationBarTitle("Consumi")
        }
        .alert(isPresented: $mostraErrore) { () -> Alert in
            Alert(title: Text("Ecco il risultato"), message: Text("Suck my dick!"), dismissButton: Alert.Button.default(Text("Ok")))
        }
        
    }
    
    func calcola() {
        if (isPressed) {
            raggio = 800
        } else {
            raggio = 100
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
