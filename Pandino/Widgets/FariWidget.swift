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
            Button(action: { self.ledAgent.toggleConnection() }) {
                Text("Connetti")
                    .font(Font.custom("Futura", size: 25))
                    .foregroundColor(Color.primary)
            }
            .frame(maxWidth: 120)
            .padding()
            .background(Color.gray.opacity(0.3))
            .clipShape(Capsule())
            
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
