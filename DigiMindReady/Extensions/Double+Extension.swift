//
//  Double+Extension.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 16/11/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import Foundation

extension Double {
    
    func removeZerosFromEnd(maximumFractionDigits: Int? = nil) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        if let maximumFractionDigits = maximumFractionDigits {
            formatter.maximumFractionDigits = maximumFractionDigits
        } else {
            formatter.maximumFractionDigits = (String(self).components(separatedBy: ".").last)?.count ?? 2
        }
        return String(formatter.string(from: number) ?? "")
    }
    
}
