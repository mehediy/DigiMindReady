//
//  ReachabilityManager.swift
//
//  Created by Md. Mehedi Hasan on 26/7/22.

import Foundation
import CoreTelephony

enum ReachabilityType {
    
    case unavailable, wifi, celluler(String)
    
    var description: String {
        switch self {
        case .unavailable: return "unavailable"
        case .wifi: return "wifi"
        case .celluler(let type):
            return type
        }
    }
    
    /// returns a boolean status
    var status: Bool {
        switch self {
        case .unavailable:
            return false
        case .wifi, .celluler:
            return true
        }
    }
    
    var isWifi: Bool {
        switch self {
        case .wifi: return true
        default: return false
        }
    }
    
    var isCelluler:Bool{
        switch self {
        case .celluler: return true
        default: return false
        }
    }
}


protocol ReachabilityManagerProtocol {
    
    
    /// A observable type for listening to network status
    var observable: Observable<ReachabilityType> { get set }
    
    /// The current status type
    var type: ReachabilityType { get }
    
    /// current boolean status
    var status: Bool { get }
}


/// For chechink current network reachability state
class ReachabilityManager: ReachabilityManagerProtocol {
    
    
    /// The shared instance for using as singleton
    static let shared = ReachabilityManager()
    
    //let reachability = try! Reachability(hostname: "www.google.com")
    let manager = try? Reachability()
    var observable: Observable<ReachabilityType> = Observable(.unavailable)
    var type: ReachabilityType { return observable.value }
    var status: Bool { return observable.value.status }
    
    private init() {
        
        manager?.whenReachable = { reachability in
//            if self.status == false {
//                let message: String
//                if reachability.connection == .wifi {
//                    message = "Network is reachable via WiFi"
//                } else {
//                    message = "Network is reachable via Mobile Data"
//                }
//                AlertUtility.showMessage(message, type: .info, duration: 1)
//            }
            
            switch reachability.connection {
            case .unavailable:
                break
                //self.observable.value = .unavailable
            case .wifi:
                self.observable.value = .wifi
            case .cellular:
                
                var networkType: String
                let networkInfo = CTTelephonyNetworkInfo()
                let carrierType = networkInfo.currentRadioAccessTechnology
                
                switch carrierType {
                case CTRadioAccessTechnologyGPRS?, CTRadioAccessTechnologyEdge?, CTRadioAccessTechnologyCDMA1x?:
                    networkType = "2g"
                case CTRadioAccessTechnologyWCDMA?, CTRadioAccessTechnologyHSDPA?, CTRadioAccessTechnologyHSUPA?, CTRadioAccessTechnologyCDMAEVDORev0?, CTRadioAccessTechnologyCDMAEVDORevA?, CTRadioAccessTechnologyCDMAEVDORevB?, CTRadioAccessTechnologyeHRPD?:
                    networkType = "3g"
                case CTRadioAccessTechnologyLTE?:
                    networkType = "4g"
                default:
                    networkType = "4g"
                }
                
                self.observable.value = .celluler(networkType)
            }
        }
        
        manager?.whenUnreachable = { _ in
            print("Not reachable")
            self.observable.value = .unavailable
            //AlertUtility.showErrorMessage("Internet connection not available")
        }
        
        
    }
    
    func stopListening() {
        manager?.stopNotifier()
    }
    
    func startListening() {
        do {
            try manager?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
