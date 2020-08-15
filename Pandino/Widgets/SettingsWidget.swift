//
//  SettingsWidget.swift
//  Pandino
//
//  Created by Dani Tox on 26/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct SettingsWidget: View {
    @EnvironmentObject var weatherAgent: WeatherAgent
    
    var body: some View {
        Text("Settings")
    }
}

struct SettingsWidget_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWidget()
    }
}
