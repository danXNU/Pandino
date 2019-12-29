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
    
    @State var fendinebbiaOn: Bool = false
    @State var abitacoloOn: Bool = false
    @State var fondoOn: Bool = false
    
    var body: some View {
        Form {
            HStack {
                Toggle(isOn: self.$fendinebbiaOn) {
                    Text("Fendinebbia")
                    .font(.custom("Futura", size: 25)).bold()
                    .foregroundColor(Color(UIColor.label))
                }
            }
            .frame(height: 60)
            
            HStack {
               Toggle(isOn: self.$abitacoloOn) {
                   Text("Abitacolo")
                .font(.custom("Futura", size: 25)).bold()
                .foregroundColor(Color(UIColor.label))
               }
            }
            .frame(height: 60)
            
            HStack {
                Toggle(isOn: self.$fondoOn) {
                    Text("Fondo")
                    .font(.custom("Futura", size: 25)).bold()
                    .foregroundColor(Color(UIColor.label))
                }
            }
            .frame(height: 60)
        }
    }
}
