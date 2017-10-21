//
//  TabBarController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit


final class TabBarController: UITabBarController {

    // MARK: - Enums

    enum Tab: Int {
        case notifies
        case chatList
        case picker
        case profile
    }

    // MARK: - Properties

    class var tabBarController: UITabBarController? {
        return UIApplication.shared.delegate?.window??.rootViewController as? UITabBarController
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Notifies
        let notifiesViewController = EventsViewController()
        notifiesViewController.tabBarItem = UITabBarItem(title: "Notifies", image: UIImage(), selectedImage: UIImage())
        let notifiesViewNavigationController = UINavigationController(rootViewController: notifiesViewController)

        // Chat list
        let chatListViewController = ChatListViewController()
        chatListViewController.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(), selectedImage: UIImage())
        let chatListViewNavigationController = UINavigationController(rootViewController: chatListViewController)

        // Picker
        let pickerViewController = PickerViewController()
        pickerViewController.tabBarItem = UITabBarItem(title: "Picker", image: UIImage(), selectedImage: UIImage())
        let pickerViewNavigationController = UINavigationController(rootViewController: pickerViewController)

        // Profile
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(), selectedImage: UIImage())
        let profileViewNavigationController = UINavigationController(rootViewController: profileViewController)

        // Set to tab bar
        self.setViewControllers(
            [   notifiesViewNavigationController,
                chatListViewNavigationController,
                pickerViewNavigationController,
                profileViewNavigationController
            ],
            animated: true
        )
    }

    // MARK: - Static methods

    static func select(tab: Tab) {
        tabBarController?.selectedIndex = tab.rawValue
    }

}
