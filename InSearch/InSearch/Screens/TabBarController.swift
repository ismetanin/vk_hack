//
//  TabBarController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let c = MyScreenViewController()
        c.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let nav = UINavigationController(rootViewController: c)
        self.setViewControllers([nav], animated: true)
    }

}
