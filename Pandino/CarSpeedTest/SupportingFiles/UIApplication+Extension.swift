//
//  UIApplication+Extension.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 11/02/21.
//

import UIKit

extension UIApplication {
    static var appVersion: String {
        let strVers = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return strVers ?? "NULL"
    }
    
    static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }
}
