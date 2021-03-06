//
//  AppDelegate.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit
import SwiftyVK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        // Init appearance
        UITabBar.appearance().tintColor = UIColor.Red.main
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().shadowImage = nil
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "img_navigation_bar_arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "img_navigation_bar_arrow")

        // Init vk delegate
        vkDelegateReference = VKDelegateImpl()

        // Init root view
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController: UIViewController

        if let _: String = KeychainStorage().loadData(forUserAccount: Constants.Keys.userAccount,
                                                      byKey: Constants.Keys.accessToken) {

            if UserDefaults.standard.isCategoriesSet {
                rootViewController = TabBarController()
            } else {
                rootViewController = SelectFavorsViewController()
            }
        } else {
            rootViewController = AuthViewController()
        }

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        // Process opening url by vk
        VK.process(url: url, sourceApplication: app)
        return true
    }
}


