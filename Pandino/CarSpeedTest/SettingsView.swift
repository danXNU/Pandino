//
//  SettingsView.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 01/02/21.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(DefaultsKeys.metricUsed) var metricUsed : MetricType = .km
    @AppStorage(DefaultsKeys.debugStart) var isDebugStart: Bool = false
    
    @State var selectedSheet: SheetType?
    
    @State var isShowingError: Bool = false
    @State var errorMsg: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                Picker("Metric type", selection: $metricUsed) {
                    ForEach(MetricType.allCases, id: \.self) { type in
                        Text("\(type.str)").tag(type)
                    }
                }
            }
            
            Section(header: Text("Info")) {
                HStack {
                    Text("App version")
                    Spacer()
                    Text("v\(UIApplication.appVersion) (\(UIApplication.appBuild))")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Report a bug")
                    Spacer()
                    Button(action: sendEmail) {
                        Text("Report")
                    }
                }
            }
            
            #if DEBUG
            Toggle("Debug start", isOn: $isDebugStart)
            #endif
        }
        .navigationTitle(Text("Settings"))
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .sheet(item: $selectedSheet) { type in
            switch type {
            case .reportBug:
                SendEmailView(subject: "Car Speedy+ [\(UIApplication.appVersion)] bug", attachments: []) { (error) in
                    selectedSheet = nil
                    if error != nil {
                        self.errorMsg = error!.localizedDescription
                        self.isShowingError = true
                    }
                }
            }
        }
        .alert(isPresented: $isShowingError) {
            Alert.init(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("OK")))
        }
    }
     
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            self.selectedSheet = .reportBug
        } else {
            self.errorMsg = "You haven't setup an email account on this device. Add one from the device settings and retry"
            self.isShowingError = true
        }
    }
    
    enum SheetType: Identifiable {
        case reportBug
        
        var id: String {
            String(describing: self)
        }
    }
    
}
