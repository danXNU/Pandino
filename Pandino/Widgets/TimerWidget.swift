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
    
    @ObservedObject var speedWatchAgent: SpeedWatchAgent
    
    @ViewBuilder
    var body: some View {
        if self.speedWatchAgent.state == .settings {
            self.timerIdleView()
        }
        if self.speedWatchAgent.state == .running {
            self.timerStartedView()
        }
        if self.speedWatchAgent.state == .finished {
            Text("PORCA DI QUELLAAAAA")
        }
    }
    
    private func timerIdleView() -> some View {
        VStack {
            Text("Speed range")
                
            Spacer()
            
            Stepper(onIncrement: incrementMinSpeed, onDecrement: decrementMinSpeed) {
                Text("From: \(minSpeed)")
                .font(Font.custom("Futura", size: 25))
            }

            Stepper(onIncrement: incrementMaxSpeed, onDecrement: decrementMaxSpeed) {
                Text("From: \(maxSpeed)")
                .font(Font.custom("Futura", size: 25))
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    self.speedWatchAgent.start(minSpeed: Double(self.minSpeed), maxSpeed: Double(self.maxSpeed))
                }) {
                    Text("Begin")
                }
                .buttonStyle(PandinoButtonStyle())
                .disabled(!canStart)
                
                if canStart {
                    Text("The stopwatch will start when you will exceed the minimun speed that you set")
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
    
    private func timerStartedView() -> some View {
        VStack {
            Text("\(self.minSpeed) - \(self.maxSpeed) mph")
            Spacer()
            
            Text("\(self.speedWatchAgent.currentSpeed.value) mph")
                .font(Font.custom("Futura", size: 25))
            
            Text("\(String(format: "%.1f", self.speedWatchAgent.timeElapsed))s")
                .font(Font.custom("Futura", size: 15))
            
            Spacer()
        }
    }
    
    private var canStart: Bool {
        return minSpeed < maxSpeed
    }
    
    private func incrementMinSpeed() {
        self.minSpeed += 1
    }
    
    private func decrementMinSpeed() {
        if self.minSpeed > 0 {
            self.minSpeed -= 1
        }
    }
    
    private func incrementMaxSpeed() {
        self.maxSpeed += 1
    }
    
    private func decrementMaxSpeed() {
        if self.maxSpeed > 0 {
            self.maxSpeed -= 1
        }
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
