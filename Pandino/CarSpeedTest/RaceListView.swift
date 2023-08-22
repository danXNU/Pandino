//
//  RaceListView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 09/02/21.
//

import SwiftUI

struct RaceListView: View {
    
    @StateObject var viewModel = RaceViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Group {
            if viewModel.races.isEmpty {
                Text("No file").bold()
            } else {
                List {
                    ForEach(viewModel.races, id: \.id) { race in
                        NavigationLink(destination: RaceView(race: race).environmentObject(viewModel)) {
                            RaceCell(race: race)
                        }
                    }
                    .onDelete(perform: delete(items:))
                }
            }
        }
        .onAppear {
            self.viewModel.fetchRaces()
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Done") {
                    viewModel.saveRaces()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle(Text("Races"))
    }
    
    func delete(items: IndexSet) {
        for index in items {
            self.viewModel.races.remove(at: index)
        }
        
        self.viewModel.saveRaces()
    }
    
}

struct RaceCell: View {
    @ObservedObject var race: RaceObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(race.name)
                .font(.title2)
            
            HStack {
                Text(speedRangeString)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(durationString)
                    .foregroundColor(.secondary)
            }
            
        }
        .contentShape(Rectangle())
    }
    
    var speedRangeString: String {
        let symbol: String = race.dataPoints.first?.value.unit.symbol ?? ""
        
        return "\(race.speedRange.lowerBound)-\(race.speedRange.upperBound) \(symbol)"
    }
    
    var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: race.duration) ?? "\(race.duration)"
        return formattedString
    }
}
