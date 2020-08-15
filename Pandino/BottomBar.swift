//
//  BottomBar.swift
//  Pandino
//
//  Created by Dani Tox on 11/01/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var widgetAgent: WidgetAgent
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemBackground))                
                
                HStack(spacing: 20) {
                    Image(systemName: "gear")
                        .resizable()
                        .foregroundColor(Color.gray.opacity(1.0))
                        .frame(width: 50, height: 50)
                        //                .offset(x: 20, y: 0)
                        .onTapGesture {
                            self.widgetAgent.toggle(with: .settings)
                        }
                    
                    
                    
                    
                    Image(systemName: "timer")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .foregroundColor(Color.gray.opacity(1.0))
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            self.widgetAgent.toggle(with: .timer)
                        }
                    
                    
                    
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            self.widgetAgent.toggle(with: .info)
                        }
                    
                    Spacer()
                }
                .offset(x: 20, y: 0)
            }
        }
        
        
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}
