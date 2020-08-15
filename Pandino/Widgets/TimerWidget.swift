//
//  TimerWidget.swift
//  Pandino
//
//  Created by Dani Tox on 15/08/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct TimerWidget: View {
    @State var minSpeed: Int = 0
    @State var maxSpeed: Int = 60
    
    @State var errorMsg: String = ""
    @State var hasStarted: Bool = false
    
    var body: some View {
        VStack {
            Text("Speed range")
                
            Spacer()
            
            Stepper(onIncrement: { self.minSpeed += 1 }, onDecrement: { self.minSpeed -= 1 }) {
                Text("From: \(minSpeed)")
                .font(Font.custom("Futura", size: 25))
            }

            Stepper(onIncrement: { self.maxSpeed += 1 }, onDecrement: { self.maxSpeed -= 1 }) {
                Text("From: \(maxSpeed)")
                .font(Font.custom("Futura", size: 25))
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: { }) {
                    Text("Begin")
                }
                .buttonStyle(PandinoButtonStyle())
                .disabled(!canStart)
                
                if canStart {
                    Text("The stopwatch will start when you will excees the minimun speed that you set")
                    .font(Font.custom("Futura", size: 15))
                    .foregroundColor(.secondary)
                } else {
                    Text("The minimun speed can't be less than the max speed")
                        .font(Font.custom("Futura", size: 15))
                        .foregroundColor(Color.red)
                }
                
            }
            
            
            Spacer()
        }
        .padding()
    }
    
    private var canStart: Bool {
        return minSpeed < maxSpeed
    }
}

struct PandinoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .font(Font.custom("Futura", size: 25))
        .foregroundColor(Color.primary)
        .frame(maxWidth: 120)
        .padding()
        .background(Color.gray.opacity(0.3))
        .clipShape(Capsule())
        .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.linear)
    }
}
