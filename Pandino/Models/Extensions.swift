//
//  Extensions.swift
//  Pandino
//
//  Created by Dani Tox on 25/03/2020.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation

extension Data {
    static func getMessage(withBytes toxBytes: [UInt8]) -> Data {
        var data = Data()
        data.append(contentsOf: toxBytes)
        return data
    }
}
