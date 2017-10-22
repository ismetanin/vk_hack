//
//  UINavigationItem.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func clearBackBarButtonItemLabel() {
        backBarButtonItem = UIBarButtonItem(title:"",
                                            style:.plain,
                                            target:nil,
                                            action:nil)
    }
}
