//
//  VKDelegateImpl.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import SwiftyVK

var vkDelegateReference: VKDelegate?

final class VKDelegateImpl: VKDelegate {

    // MARK: - Constants

    private let appID = "3913450"
    private let scope: Set<VK.Scope> = [.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]

    // MARK: - Initialization and deinitialization

    init() {
        VK.config.logToConsole = true
        VK.configure(withAppId: appID, delegate: self)
    }

    // MARK: - VKDelegate

    func vkWillAuthorize() -> Set<VK.Scope> {
        return scope
    }

    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        // 
        if let accessToken = parameters[Constants.Keys.accessToken] {
            AuthorizationService().sendToken(token: accessToken, completion: { (result) in
                debugPrint("yoyoyoyo")
            })
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "VkDidAuthorize"), object: nil)
    }

    func vkAutorizationFailedWith(error: AuthError) {
        print("Autorization failed with error: \n\(error)")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "VkDidNotAuthorize"), object: nil)
    }

    func vkDidUnauthorize() {}

    func vkShouldUseTokenPath() -> String? {
        return nil
    }

    func vkWillPresentView() -> UIViewController {
        return DispatchQueue.main.sync {
            return UIApplication.shared.delegate?.window??.rootViewController ?? UIViewController()
        }
    }
    
}
