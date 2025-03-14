//
//  Number+Extension.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 16/12/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import UIKit

class Device {
    // Base width in point, use iPhone 6
    static let base: CGFloat = 375
    
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}

extension CGFloat {
    var dynamic: CGFloat {
        return self * Device.ratio
    }
}

extension Double {
    var dynamic: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}

extension Int {
    var dynamic: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
