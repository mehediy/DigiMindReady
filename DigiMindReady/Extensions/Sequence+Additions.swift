//
//  Sequence+Additions.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 23/9/21.
//  Copyright © 2021 GrameenPhone Ltd. All rights reserved.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
