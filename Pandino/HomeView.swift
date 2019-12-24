//
//  HomeView.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var isShowingWidget: Bool = true
    
    var body: some View {
        
        ConsumiWidgetView(isShowing: self.$isShowingWidget)
        .frame(width: 500, height: 400)
        .opacity(isShowingWidget ? 1.0 : 0.0)
        .animation(.easeIn)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
