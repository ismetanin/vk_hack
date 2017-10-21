//
//  FavorsTableViewCell.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class FavorsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var shevronImage: UIImageView!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Internal methods

    func fill(category: Category, isSelected: Bool) {
        titleLabel.text = category.title
        gradientView.isHidden = !isSelected
        shevronImage.isHidden = !isSelected
        iconImageView.image = isSelected ? category.selectedImage : category.normalImage
        titleLabel.textColor = isSelected ? UIColor.white : UIColor.Gray.main
    }

}
