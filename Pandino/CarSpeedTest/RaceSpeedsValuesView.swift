//
//  RaceSpeedsValuesView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 10/02/21.
//

import SwiftUI

struct RaceSpeedsValuesView: View {
    var race: RaceObject
    
    var body: some View {
        List(race.dataPoints) { point in
            HStack {
                Text(timeOffset(point: point))
                Spacer()
                Text("\(speedString(point: point)) \(point.value.unit.symbol)")
                    .foregroundColor(.secondary)
            }
        }
        .navigationBarTitle(Text("Speeds"), displayMode: .inline)
    }
    
    func speedString(point: DataPoint) -> String {
        String(format: "%.1f", point.value.value)
    }
    
    func timeOffset(point: DataPoint) -> String {
        return String(format: "%.1fs", point.timeOffset)
    }
}
