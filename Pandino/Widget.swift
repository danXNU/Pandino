//
//  Widget.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct Widget<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack {
            self.content()
            
            CloseButton {
                self.isShowing.toggle()
            }
        }
    }
}
