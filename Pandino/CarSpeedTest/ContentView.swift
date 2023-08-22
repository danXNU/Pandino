//
//  ContentView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 29/01/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SpeedViewModel()
    
    @AppStorage(DefaultsKeys.startSpeed) var start: Int = 0
    @AppStorage(DefaultsKeys.distance) var distance: Int = 60
    @AppStorage(DefaultsKeys.metricUsed) var metricUsed: MetricType = .km
    
    @State var selectedSheet: SheetType?

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                VerticalView
            } else {
                HorizontalView
            }
        }
        .padding()
        .fullScreenCover(item: $selectedSheet) { type in
            switch type {
            case .settings:
                NavigationView {
                    SettingsView()
                }
            case .raceList:
                NavigationView {
                    RaceListView()
                }
            }
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMsg), dismissButton: .default(Text("OK")))
        }
        .onChange(of: start) { (newValue) in
            self.viewModel.speedRange = newValue...end
        }
        .onChange(of: distance) { (newValue) in
            self.viewModel.speedRange = start...end
        }
        .onAppear {
            viewModel.speedRange = start...end
        }
    }
    
    //MARK: - Horizontal View
    var HorizontalView: some View {
        Group {
            switch viewModel.viewState {
            case .normal:
                ZStack {
                    VStack(spacing: 30) {
                        speedView
                        
                        SpeedRangeSelectorView
                        
                        Button(action: ready) {
                            Text("Ready")
                                .bold()
                                .font(.largeTitle)
                        }
                        .buttonStyle(OSSetupButtonStyle())
                        .frame(maxWidth: 200)
                    }

                    RaceListButton
                    
                    SettingsButton
                    
                }
            case .waitingStart:
                HStack(spacing: 20) {
                    VStack {
                        SpeedometerView
                        
                        ResetButton()
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("Warning")
                            .bold()
                            .font(.title)
                            
                        
                        TimerStartMessageView
                    }
                }
            case .running:
                HStack {
                    VStack(spacing: 20) {
                        Spacer()
                        
                        SpeedometerView
                        
                        Text("\(elapsedTimeString)").bold().font(.title).animation(viewModel.viewState == .running ? nil : .default)
                        
                        Spacer()
                        
                        ResetButton()
                        
                        Spacer()
                    }
                    
                    Chart
                        .padding(20)
                }
                .padding()
            case .finished:
                HStack(spacing: 20) {
                    VStack {
                        Spacer()
                        
                        Text("Finished!")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Duration: \(durationString)").bold().font(.title)
                        
                        Spacer()
                        
                        ResetButton(done: true)
                    }
                    .padding(.vertical)
                    
                    Chart
                }
            case .error(let error):
                HStack(spacing: 20) {
                    VStack {
                        SpeedometerView
                        
                        ResetButton()
                    }
                    
                    Divider()
                    
                    VStack {
                        ErrorPlaceholderView(error: error)
                        
                        ErrorTextView(error: error)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Vertical View
    var VerticalView: some View {
        Group {
            switch viewModel.viewState {
            case .normal:
                ZStack {
                    ScrollView {
                        VStack(spacing: 40) {
                            Spacer()
                            
                            speedView
                            
                            SpeedRangeSelectorView
                            
                            Spacer()
                            
                            Button(action: ready) {
                                Text("Ready")
                                    .bold()
                                    .font(.largeTitle)
                            }
                            .buttonStyle(OSSetupButtonStyle())
                            .frame(maxWidth: 200)
                        }
                    }
                    
                    RaceListButton
                    SettingsButton
                }
            case .waitingStart:
                ScrollView {
                    VStack(spacing: 40) {
                        Spacer()
                        speedView
                        
                        Text("Waiting start")
                        Text("The timer will start automatically when the car starts moving")
                        Spacer()
                        ResetButton()
                    }
                }
                
            case .running:
                ScrollView {
                    VStack(spacing: 40) {
                        Spacer()
                        Text("\(elapsedTimeString)").bold().font(.title).animation(viewModel.viewState == .running ? nil : .default)
                        
                        SpeedometerView
                        
                        Chart
                            .frame(height: 300)
                        
                        
                        ResetButton()
                    }
                }
            case .finished:
                ScrollView {
                    VStack(spacing: 40) {
                        Text("Finished")
                        Text("Duration: \(durationString)").bold().font(.title)
                        
                        Chart
                            .frame(height: 300)
                        
                        ResetButton(done: true)
                    }
                }
            case .error(let error):
                ScrollView {
                    VStack(spacing: 40) {
                        SpeedometerView
                        
                        ErrorPlaceholderView(error: error)
                        
                        ErrorTextView(error: error)
                        
                        ResetButton()
                    }
                }
            }
        }
    }
    
    //MARK: - Helper views
//    Text("\(start) - \(end) \(metricUsed.str)").bold()
    
    var SpeedRangeSelectorView: some View {
        GroupBox(label: Label("Speed range: \(start) - \(end) \(metricUsed.str)", systemImage: "speedometer")) {
            VStack {
                VStack {
                    Text("Start speed (\(metricUsed.str))").bold()
                    
                    HStack {
                        Text("0")
                            .bold()
                        
                        Slider(value: startSpeedBinding, in: allowedRange)
                        
                        Text("200").bold()
                    }
                }
                
                
                Divider()
                
                VStack {
                    Text("Distance (\(metricUsed.str))").bold()
                    
                    HStack {
                        Text("10")
                        
                        Slider(value: distanceBinding, in: allowedDistanceRange)
                        
                        Text("100")
                    }
                }
            }
            .padding()
        }
    }
    
    var TimerStartMessageView: some View {
        let str: String = start == 0 ? "The timer will start automatically when the car starts moving" : "The timer will start when you'll enter the speed range \(start)-\(end) that you set."
        
        return Text(str)
            .font(.title)
            .padding()
            .foregroundColor(Color.white)
            .background(
                Color.green
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
    
    var SettingsButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: { selectedSheet = .settings }) {
                    Image(systemName: "gear")
                        .font(.largeTitle)
                }
            }
        }
    }
    
    var RaceListButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: { selectedSheet = .raceList }) {
                    Image(systemName: "scroll")
                        .font(.largeTitle)
                }
                
                Spacer()
            }
        }
    }
    
    func ErrorPlaceholderView(error: SpeedError) -> some View {
        Text(error.isWarning ? "Warning" : "Error")
            .bold()
            .font(.title)
    }
    
    func ErrorTextView(error: SpeedError) -> some View {
        func background(error: SpeedError) -> some View {
            if error.isWarning {
                return Color.orange
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                return Color.red
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        
        return Text(error.stringValue)
            
            .font(.title)
            .padding()
            .foregroundColor(Color.white)
            .background(
                background(error: error)
            )
    }
    
    func ResetButton(done: Bool = false) -> some View {
        Button(action: reset) {
            Text(done ? "Done" : "Cancel")
                .foregroundColor(.white)
                .bold()
                .font(.largeTitle)
                .padding()
                .background(
                    Color.red
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
                
        }
    }
    
    var Chart: some View {
        ChartView(minSpeed: CGFloat(start), maxSpeed: CGFloat(end), dataPoints: viewModel.dataPoints, spacingValue: 20)
            .frame(maxWidth: .infinity)
    }
    
    var SpeedometerView: some View {
        Speedometer(speed: Int(viewModel.speed.value), range: start...end, debug: false)
            .frame(width: 200, height: 200)
//            .overlay(Rectangle().stroke(Color.blue))
            .animation(Animation.easeInOut(duration: 1))
    }
    
    var speedView: some View {
        Text("\(Int(viewModel.speed.value)) \(metricUsed.str)")
            .bold()
            .font(.largeTitle)
            .animation(viewModel.viewState == .running ? nil : .default)
    }
    
    //MARK: - Functions
    func ready() {
        viewModel.prepareToStart()
    }
    
    func reset() {
        self.viewModel.reset()
    }
    
    func stop() {
        self.viewModel.cancel()
    }
    
    func getString(time: CFAbsoluteTime) -> String {
        return formatter.string(from: Date(timeIntervalSinceReferenceDate: time))
    }
    
    func getDurationString() -> String {
        let f = DateFormatter()
        f.dateFormat = "ss.SSSS"
        return f.string(from: Date(timeIntervalSinceReferenceDate: viewModel.duration))
    }
    
    
    //MARK: - Helper variables
    var durationString: String {
        String(format: "%.1f", viewModel.duration)
    }
    
    var elapsedTimeString: String {
        String(format: "%.1f", viewModel.elapsedTime)
    }
    
    var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "hh:mm:ss"
        return f
    }
    
    var startSpeedBinding: Binding<Float> {
        Binding {
            Float(start)
        } set: {
            start = Int($0)
        }
    }
    
    var distanceBinding: Binding<Float> {
        Binding {
            Float(distance)
        } set: {
            distance = Int($0)
        }
    }
    
    var allowedRange: ClosedRange<Float> {
        0...200
    }
    
    var allowedDistanceRange: ClosedRange<Float> {
        10...100
    }
    
    var end: Int {
        start + distance
    }
    
    enum SheetType: Identifiable {
        case settings
        case raceList
        
        var id: String {
            String(describing: self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
