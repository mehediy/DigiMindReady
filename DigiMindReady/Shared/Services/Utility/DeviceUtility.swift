//
//  DeviceUtility.swift
//
//  Created by Md. Mehedi Hasan on 26/7/22.
//

import Foundation

import UIKit

public class DeviceUtility {
    
    static var isNotchFamily: Bool {
       if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
       } else if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
       }
       return false
    }
}
