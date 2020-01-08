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
    case consumi
    case info
    case settings
    case fari
    case coordinate
    case weather
    
    var widgetBarTitle: String {
        switch self {
        case .consumi: return "Consumi"
        case .info: return "Info"
        case .settings: return "Impostazioni"
        case .fari: return "Fari"
        case .coordinate: return "Coordinate"
        case .weather: return "Tempo"
        }
    }
}

class WidgetAgent: ObservableObject {
    @Published var isShowingWidget: Bool = false
    @Published var selectedWidget: WidgetType = .consumi
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
    
    private func closeWidget() {
        self.selectedWidget = .consumi
        self.isShowingWidget = false
        self.widgetOffset = CGSize(width: 0, height: -1000)
    }
    
}
