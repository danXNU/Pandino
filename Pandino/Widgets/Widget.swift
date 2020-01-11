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
    var closeAction: (() -> Void)? = nil
    var content: () -> Content
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .shadow(color: Color.black, radius: 20)
                
                VStack {
                    WidgetBar(cornerRadius: 20, title: self.type.widgetBarTitle, closeAction: self.closeAction == nil ? { self.widgetAgent.toggle(with: self.type)} : self.closeAction)
                        .frame(height: 70)
                    
                    self.content()
                        .frame(height: geo.size.height - 70)
                }
            
            }
        }
        
    }
}
