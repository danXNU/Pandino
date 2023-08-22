//
//  Speedometer.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 31/01/21.
//

import SwiftUI

struct Speedometer: View {
    var speed: Int
    var range: ClosedRange<Int> = 0...100
    
    var debug: Bool = false
    
    private let diff = Angle.degrees(90)
    private let lineWidth: CGFloat = 20
    
    @AppStorage(DefaultsKeys.metricUsed) var metricUsed: MetricType = .km
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                SpeedPath()
                    .strokeBorder(
                        AngularGradient(gradient: Gradient(colors: [.green, .green, .yellow, .red, .red]),
                                        center: .center,
                                        angle: .degrees(180) - diff),
                        lineWidth: lineWidth
                    )
                    .frame(width: geo.size.width)
                
                if debug {
                    SpeedPath()
                        .stroke(Color.blue)
                        .frame(width: geo.size.width - lineWidth)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 2, height: 40)
                        .rotationEffect(Angle(degrees: Double(getAngle())) - diff, anchor: .top)
                }
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: lineWidth, height: lineWidth)
                    .position(getPoint(size: geo.size))
                
                
                
                VStack(alignment: HorizontalAlignment.center) {
                    HStack {
                        Text("\(range.lowerBound)").bold()
                        
                        Spacer()
                        
                        Text("\(range.upperBound)").bold()
                    }
                }
                .offset(x: 0, y: 10)
                
                VStack {
                    Text("\(speed)")
                        .bold()
                        .font(.largeTitle)
                    
                    Text(metricUsed.str)
                        .font(.title)
                }
            }
            
            
        }
    }
    
    func getAngle() -> Int {
        //speed : maxSpeed = x : 180
        var _speed : Int = speed
        _speed = min(_speed, range.upperBound)
        _speed = max(_speed, range.lowerBound)
        _speed -= range.lowerBound
        
        let angle = _speed * 180 / (range.upperBound - range.lowerBound)
        print(angle)
        return angle - 180
    }
    
    private func getPoint(size: CGSize) -> CGPoint {
        let angle = getAngle()
        // 1
        let radius = Double((size.width - lineWidth) / 2)

        // 2
        let radian = Angle(degrees: Double(angle)).radians

        // 3
        let newCenterX : Double = radius + radius * cos(radian)
        let newCenterY : Double = radius + radius * sin(radian)

        let offset : Double = Double(lineWidth / 2)
        
        return CGPoint(x: newCenterX + offset, y: newCenterY + offset)
      }
    
}

struct SpeedPath: InsettableShape {
    var inset: CGFloat = 0
    
    private let diff = Angle.degrees(90)
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addArc(center: CGPoint(x: rect.midX, y:rect.midY),
                 radius: rect.width / 2 - inset,
                 startAngle: (.degrees(270) - diff),
                 endAngle: (.degrees(90) - diff),
                 clockwise: false)
        
        
        return p
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.inset += amount
        return arc
    }
}
