//
//  WidgetAgent.swift
//  Pandino
//
//  Created by Dani Tox on 25/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import SwiftUI

enum WidgetType {
    case info
    case settings
    case coordinate
    case timer
    
    var widgetBarTitle: String {
        switch self {
        case .info: return "Info"
        case .settings: return "Settings"
        case .coordinate: return "Coordinates"
        case .timer: return "Timer"
        }
    }
}

class WidgetAgent: ObservableObject {
    @Published var isShowingWidget: Bool = false
    @Published var selectedWidget: WidgetType = .timer
    @Published var widgetOffset: CGSize = CGSize(width: 0, height: -1000)
    
    public func toggle(with widgetType: WidgetType) {
        if isShowingWidget {
            closeWidget()
        } else {
            showWidget(type: widgetType)
        }
    }
    
    private func showWidget(type: WidgetType) {
        self.selectedWidget = type
        self.isShowingWidget = true
        withAnimation(.spring()) {
            self.widgetOffset = .zero
        }
    }
    
    public func closeWidget() {
        self.selectedWidget = .timer
        self.isShowingWidget = false
        self.widgetOffset = CGSize(width: 0, height: -1000)
    }
    
}
