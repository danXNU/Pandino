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
    @State var selectedWidget: WidgetTypes = .consumi
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    CarNavigationView(isShowingWidget: self.$isShowingWidget, whatWidget: self.$selectedWidget)
                        .frame(width: geo.size.width / 3)
                    
                    //Map View
                    MapView()
                        .edgesIgnoringSafeArea(.all)
                }
                
                
                if self.isShowingWidget {
                    self.SelectedWidget()
                        .frame(width: 500, height: 400)
                        .animation(.easeIn)
                }
                
            }
        }
    }
    
    func SelectedWidget() -> some View {
        switch self.selectedWidget {
        case .consumi:
            return Widget(isShowing: self.$isShowingWidget) {
                ConsumiWidgetView()
            }
            //        default: fatalError()
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
