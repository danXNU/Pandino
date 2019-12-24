//
//  CloseButton.swift
//  Pandino
//
//  Created by Dani Tox on 24/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI

struct CloseButton: View {
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: { self.action?() }) {
                    Text("×")
                        .font(Font.largeTitle)
                        .offset(x: 0.25, y: -2)
                }
                .padding(7)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
                .foregroundColor(Color.white)
                .offset(x: 10, y: 0)
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
