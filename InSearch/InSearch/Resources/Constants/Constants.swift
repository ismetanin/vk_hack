//
//  Constants.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

enum URLs {
    static var base = "https://77.244.217.34/v1/"
    static var auth = "auth"
}

enum Constants {
    enum Keys {
        static var accessToken = "access_token"
        static var userAccount = "InSearchUserAccount"
    }
}

// MARK: - NSNotification

extension NSNotification.Name {
    static let userLoggedIn = NSNotification.Name("InSearch.notifications.userLoggedIn")
    static let userFailedLogIn = NSNotification.Name("InSearch.notifications.userFailedLogIn")
}
