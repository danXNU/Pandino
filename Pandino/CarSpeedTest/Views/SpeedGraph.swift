//
//  SpeedGraph.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 01/02/21.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    var minSpeed: CGFloat
    var maxSpeed: CGFloat
    var dataPoints: [DataPoint]
    var showLabels: Bool = true
    var spacingValue: Int = 10
    
    private var points: [Int] { dataPoints.compactMap { Int($0.value.value) } }
    
    var body: some View {
        ZStack(alignment: Alignment.bottomLeading) {
            if #available(iOS 16, *) {
                Chart(dataPoints, id: \.id) { dataPoint in
                    LineMark(x: .value("Time", dataPoint.timeOffset),
                             y: .value("Speed", dataPoint.value.value))
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .foregroundStyle(Color.blue.gradient)
                    .interpolationMethod(InterpolationMethod.cardinal)
                }
            } else {
                HStack {

                    VStack {
                        Text("\(Int(maxSpeed))")
                        Spacer()
                        Text(String(format: "%1.f", maxSpeed / 2))
                        Spacer()
                        Text(String(format: "%1.f", minSpeed))
                    }
                    .padding(.bottom)

                    VStack {
                        ZStack {
                            ChartLinesShape()
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 5))

                            LineChartShape(max: Int(maxSpeed), points: points)
                                .stroke(style: StrokeStyle(lineWidth: 5))
                                .frame(maxWidth: .infinity)
    //                            .overlay(Rectangle().stroke(Color.purple))
                        }


                        HStack {
                            Text("0")
                            Spacer()
                            Text(halfTimeOffset)
                            Spacer()
                            Text(timeOffset)
                        }
                    }
                }
            }
        }
    }
    
    var maxValueString: String {
        let value = dataPoints.max(by: { $0.value > $1.value })?.value.value ?? 0
        return String(format: "%.1f", value)
    }
    
    var halfTimeOffset: String {
        let time = dataPoints.last?.timeOffset ?? 0
        return String(format: "%.1fs", time / 2)
    }
    
    var timeOffset: String {
        let time = dataPoints.last?.timeOffset ?? 0
        return String(format: "%.0fs", time)
    }
}

struct ChartLinesShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .init(x: 0, y: rect.maxY))
        p.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        
        p.move(to: .init(x: 0, y: rect.maxY))
        p.addLine(to: .init(x: 0, y: rect.minY))
        
        return p
    }
}

struct LineChartShape: InsettableShape {
    
    var max: Int?
    var points: [Int]
    
    var inset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .init(x: rect.minX, y: rect.maxY))
        
        for (index, point) in points.enumerated() {
            let baseOffset = rect.size.width / CGFloat(points.count)
            
            let offsetX = baseOffset * CGFloat(index) + baseOffset
            let offsetY = rect.size.height - getHeight(value: point, size: rect.size)
            
            let newPoint = CGPoint.init(x: offsetX,
                                        y: offsetY)
            p.addLine(to: newPoint)
        }
        
        return p
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.inset += amount
        return shape
    }
    
    func getHeight(value: Int, size: CGSize) -> CGFloat {
        let max = CGFloat(self.max ?? (points.max() ?? 100))
        return CGFloat(value) * size.height / max
    }
    
}
