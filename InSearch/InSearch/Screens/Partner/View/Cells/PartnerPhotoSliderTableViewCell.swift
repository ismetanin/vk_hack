//
//  PartnerPhotoSliderTableViewCell.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PartnerPhotoSliderTableViewCell: UITableViewCell {
    
    // MARK: - Enums
    
    private enum Constants {
        static let height: CGFloat = 389.0
    }
    
    // MARK: - Internal helpers

    func configure(with urlStrings: [String]) {
        let photoSlider = PhotoSlider.instanceFromNib()
        photoSlider.translatesAutoresizingMaskIntoConstraints = false
        photoSlider.configure(with: urlStrings, buttonHidden: true)
        self.addSubview(photoSlider)
        NSLayoutConstraint.activate([
            photoSlider.topAnchor.constraint(equalTo: self.topAnchor),
            photoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoSlider.heightAnchor.constraint(equalToConstant: Constants.height),
            photoSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
