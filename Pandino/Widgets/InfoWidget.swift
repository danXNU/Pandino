//
//  InfoWidget.swift
//  Pandino
//
//  Created by Dani Tox on 25/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct InfoWidget: View {
    var body: some View {
        Form {
            HStack {
                Text("Sviluppatore")
                    .font(.custom("Futura", size: 25)).bold()
                    .foregroundColor(Color(UIColor.label))
                    
                Spacer()
                Text("danXNU")
                    .font(.custom("Futura", size: 25)).bold()
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
            .frame(height: 60)
            
            HStack {
                Text("Versione")
                    .font(.custom("Futura", size: 25)).bold()
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
                
                Text("0.0.1-alpha1")
                .font(.custom("Futura", size: 25)).bold()
                .foregroundColor(Color(UIColor.secondaryLabel))
            }
            .frame(height: 60)
        }
    }
}

struct InfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        InfoWidget()
    }
}
