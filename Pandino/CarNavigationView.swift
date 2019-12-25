//
//  CarNavigationView.swift
//  Pandino
//
//  Created by Dani Tox on 25/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct CarNavigationView: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.all)
                .shadow(color: Color.primary, radius: 20)
                
            
            VStack {
                Spacer()
                
                VStack {
                    Text("0")
                        .font(Font.system(size: 50, weight: .bold, design: .default))
                    
                    Text("Km/h")
                }
                
                Spacer()
                Image("fiat-panda")
                    .resizable()
                    .frame(width: 400, height: 300)
                
                Spacer()
            }
        }
    }
}

struct CarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CarNavigationView()
    }
}
