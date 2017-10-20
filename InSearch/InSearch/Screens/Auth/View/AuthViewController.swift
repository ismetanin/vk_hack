//
//  AuthViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit
import SwiftyVK

final class AuthViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var enterButton: UIButton!

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - IBActions

    @IBAction func enterButtonAction(_ sender: UIButton) {
        VK.logIn()
    }

    // MARK: - Initialization and deinitialization

    deinit {
        unsubscribeFromNotifications()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        fillStaticTexts()
        subscribeToNotifications()
    }

    // MARK: - Internal helpers


    // MARK: - Private helpers

    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userLoggedIn),
            name: NSNotification.Name.userLoggedIn,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userFailedLogIn),
            name: NSNotification.Name.userLoggedIn,
            object: nil
        )
    }

    @objc
    private func userLoggedIn() {
        let selectFavors = SelectFavorsViewController()
        present(selectFavors, animated: true, completion: nil)
    }

    @objc
    private func userFailedLogIn() {
        // TODO: show error message
    }

    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.userLoggedIn,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.userFailedLogIn,
            object: nil
        )
    }

    private func fillStaticTexts() {
        enterButton.setTitle(L10n.Auth.enterButtonTitle, for: .normal)
    }
}
