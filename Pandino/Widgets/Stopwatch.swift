//
//  Stopwatch.swift
//  Pandino
//
//  Created by Daniel Bazzani on 27/05/21.
//  Copyright © 2021 Dani Tox. All rights reserved.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ContentView()
    }
}

struct TodoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Apple CarPlay!")
            Text("Visualizzatore pandino in 3D Tesla-like")
            Text("Videocamere")
            Text("Super logger (scatola nera)")
        }
        .font(.custom("Futura", size: 40))
    }
}
