//
//  UIView.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

extension UIView {
    /// Делает скругленные края
    ///
    /// - Parameter radius: радиус скругления
    func round(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
