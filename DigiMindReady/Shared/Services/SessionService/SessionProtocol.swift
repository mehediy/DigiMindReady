//
//  SessionProtocol.swift
//
//  Created by Md. Mehedi Hasan on 22/9/20.
//

import Foundation

protocol SessionServiceProtocol {
    func invalidate()
}

enum SessionMode {
    case authenticated(token: String)
    case guest
    case none
    
    var isLoggedIn: Bool {
        switch self {
        case .none:
            return false
        default:
            return true
        }
    }
}
