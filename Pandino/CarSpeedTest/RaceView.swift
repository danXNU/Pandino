//
//  RaceView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 10/02/21.
//

import SwiftUI

struct RaceView: View {
    @EnvironmentObject var raceViewModel: RaceViewModel
    @ObservedObject var race: RaceObject
    
    @State var isEditing: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Info")) {
                HStack {
                    if isEditing {
                        TextField("Name", text: nameBinding)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(nameBinding.wrappedValue)
                    }
                    Spacer()
                    Button(action: editOrSave) {
                        Text(isEditing ? "Save" : "Edit")
                    }
                }
                
                
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(durationString)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Date")
                    Spacer()
                    Text(dateString)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Speed range")
                    Spacer()
                    Text(speedRangeString)
                        .foregroundColor(.secondary)
                }
                
            }
            
            Section(header: Text("Chart")) {
                ChartView(minSpeed: CGFloat(race.speedRange.lowerBound),
                          maxSpeed: CGFloat(race.speedRange.upperBound),
                          dataPoints: race.dataPoints)
                    .frame(minHeight: 400)
                NavigationLink(destination: RaceSpeedsValuesView(race: race)) {
                    Text("Speed values")
                }
            }
            
        }
        .onDisappear {
            raceViewModel.saveRaces()
        }
        .navigationBarTitle(Text("Details"), displayMode: .inline)
    }
    
    func editOrSave() {
        if isEditing {
            raceViewModel.saveRaces()
        }
        
        isEditing.toggle()
    }
    
    var nameBinding: Binding<String> {
        Binding {
            race.name
        } set: {
            race.name = $0
        }
    }
    
    var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: race.duration) ?? "\(race.duration)"
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: race.date)
    }
    
    var speedRangeString: String {
        let symbol: String = race.dataPoints.first?.value.unit.symbol ?? ""
        
        return "\(race.speedRange.lowerBound)-\(race.speedRange.upperBound) \(symbol)"
    }
    
}
