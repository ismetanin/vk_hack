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
        let notifiesViewController = NotifiesViewController()
        notifiesViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "logo_notifies_tab"),
            selectedImage: #imageLiteral(resourceName: "logo_notifies_tab_selected")
        )
        notifiesViewController.navigationItem.leftBarButtonItem = LeftTitleBarButtonItem(
            with: L10n.Reactions.title
        )
        notifiesViewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        let notifiesViewNavigationController = UINavigationController(rootViewController: notifiesViewController)


//        // Chat list
//        let chatListViewController = ChatListViewController()
//        chatListViewController.tabBarItem = UITabBarItem(
//            title: nil,
//            image: #imageLiteral(resourceName: "logo_messages_tab"),
//            selectedImage: #imageLiteral(resourceName: "logo_messages_tab_selected")
//        )
//        chatListViewController.navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
//        let chatListViewNavigationController = UINavigationController(rootViewController: chatListViewController)

        // Picker
        let pickerViewController = PickerViewController()
        pickerViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "logo_picker_tab"),
            selectedImage: #imageLiteral(resourceName: "logo_picker_tab_selected")
        )
        pickerViewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        let pickerViewNavigationController = UINavigationController(rootViewController: pickerViewController)

        // Profile
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "logo_profile_tab"),
            selectedImage: #imageLiteral(resourceName: "logo_profile_tab_selected")
        )
        profileViewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        let profileViewNavigationController = UINavigationController(rootViewController: profileViewController)

        // Set to tab bar
        self.setViewControllers(
            [   notifiesViewNavigationController,
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
