//
//  Widget.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct Widget<Content>: View where Content: View {

    @EnvironmentObject var widgetAgent: WidgetAgent
    
    var type: WidgetType
    var content: () -> Content

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.systemBackground))
                .shadow(color: Color(UIColor.label), radius: 20)
            
            self.content()
            
            CloseButton {
                self.widgetAgent.toggle(with: self.type)
            }
        }
    }
}
