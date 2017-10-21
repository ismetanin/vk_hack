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

        // Init vk delegate
        vkDelegateReference = VKDelegateImpl()

        // Init root view
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = AuthViewController()

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


