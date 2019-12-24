//
//  HomeView.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var isShowingWidget: Bool = false
    
    var body: some View {
        
        
        
        ZStack {
            Button(action: {
                withAnimation(Animation.easeIn(duration: 0.3)) {
                    self.isShowingWidget.toggle()
                }
                
                
            }) {
                Text("Consumi")
            }
            
            if isShowingWidget {
                Widget(isShowing: self.$isShowingWidget) {
                    ConsumiWidgetView()
                }
                .frame(width: 500, height: 400)
                .animation(.easeIn)
                
                
            }
            
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
