//
//  ProfileViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit
import SwiftyVK

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        VK.logIn()
    }

    // MARK: - Internal helpers

}
