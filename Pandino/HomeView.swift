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
        GeometryReader { geo in
            ZStack {
                
                
                if self.isShowingWidget {
                    Widget(isShowing: self.$isShowingWidget) {
                        ConsumiWidgetView()
                    }
                    .frame(width: 500, height: 400)
                    .animation(.easeIn)
                }
                  
                HStack {
                    CarNavigationView()
                    .frame(width: geo.size.width / 3)
//                    .shadow(radius: 10)
                    
                    //Spacer()

                    //Map View
                    MapView()
                        .edgesIgnoringSafeArea(.all)
//                    Rectangle()
//                        .edgesIgnoringSafeArea(.all)
//                        .foregroundColor(Color(UIColor.systemBackground))
                }
                
                
       
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
