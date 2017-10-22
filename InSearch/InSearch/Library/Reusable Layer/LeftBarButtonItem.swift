//
//  LeftBarButtonItem.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

/// Bar Button Item для отображения заголовка слева
final class LeftTitleBarButtonItem: UIBarButtonItem {
    
    // MARK: - Initialization and deinitialization
    
    init(with title: String) {
        super.init()
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.text = title
        label.sizeToFit()
        customView = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
