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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.white)
            
            Text("Info")
        }
        
        
        
    }
}

struct InfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        InfoWidget()
    }
}
