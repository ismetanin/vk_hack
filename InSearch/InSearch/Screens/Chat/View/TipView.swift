//
//  TipView.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class TipView: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Properties

    // MARK: - Internal methods

    func fill(with description: String) {
        self.descriptionLabel.text = description
    }

}
