//
//  SavedProperties.swift
//  Pandino
//
//  Created by Dani Tox on 25/05/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation

var weatherUpdateTime: Double {
    get {
        return UserDefaults.standard.double(forKey: "weatherUpdateTime")
    } set {
        UserDefaults.standard.set(newValue, forKey: "weatherUpdateTime")
    }
}
