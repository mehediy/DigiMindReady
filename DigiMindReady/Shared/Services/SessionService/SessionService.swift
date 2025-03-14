//
//  SessionService.swift
//
//  Created by Md. Mehedi Hasan on 22/9/20.
//

import Foundation

final class SessionService: SessionServiceProtocol {
    
    static let shared = SessionService()
    
    var isRelaunched: Bool {
        guard isNewSession else {
            return false
        }
        
        isNewSession = false
        return true
    }

    
    var mode: SessionMode {
        return .guest
        
//        if let token = UserSessionManager.shared.accessToken {
//            return .authenticated(token: token)
//        } else if UserSessionManager.shared.isGuestMode {
//            return .guest
//        } else {
//            return .none
//        }
    }
    
    var isNewSession: Bool
    
    private init() {
        isNewSession = true
    }
    
    //MARK: Stored Property
    //var notificationList: [NotificationDetail] = []
    
    //var prayerObservable:Observable<[String]> = Observable()
    
    func invalidate() {
        //seenNotificationIDs = nil
    }
}
