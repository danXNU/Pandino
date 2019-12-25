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
                        .foregroundColor(Color.primary)
                        .font(Font.system(size: 40))
                        .offset(x: 0.25, y: -2)
                }
                .padding(7)
                .background(Color.gray.opacity(0.3))
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
