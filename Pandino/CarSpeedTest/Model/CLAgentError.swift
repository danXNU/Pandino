//
//  CLAgentError.swift
//  Car SpeedTest+
//
//  Created by Daniel Bazzani on 11/02/21.
//

import Foundation

enum CLAgentError: Error {
    case deniedAccess
    case notImportant
    case internalError(Error)
}
