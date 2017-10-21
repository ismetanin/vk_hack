//
//  UINavigationController.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if let currentViewController = self.viewControllers.last {
            return currentViewController.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
}
