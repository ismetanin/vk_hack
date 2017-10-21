//
//  CGAffineTransform.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

extension CGAffineTransform {
    /// Устанавливает стандартные значения
    static var `default`: CGAffineTransform {
        return CGAffineTransform(scaleX: 1.0, y: 1.0).translatedBy(x: 0.0, y: 0.0).rotated(by: 0.0)
    }
}
