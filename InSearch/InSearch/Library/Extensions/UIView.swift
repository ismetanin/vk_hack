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
    }
    
    func roundSquare() {
        layer.cornerRadius = frame.width / 2
    }
    
    func addShadow(opacity: Float) {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: layer.cornerRadius / 2)
        layer.shadowOpacity = opacity
        layer.shadowRadius = layer.cornerRadius / 2
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
