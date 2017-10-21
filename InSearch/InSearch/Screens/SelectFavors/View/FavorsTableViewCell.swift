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

    // MARK: - Properties

    private var category: Category?
    private var isCellSelected: Bool = false

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        guard let category = category else {
            return
        }
//        if highlighted {
            fill(category: category, isSelected: !isCellSelected)
//        } else {
//
//        }
    }

    // MARK: - Internal methods

    func fill(category: Category, isSelected: Bool) {
        self.category = category
        self.isCellSelected = isSelected
        titleLabel.text = category.title
        gradientView.isHidden = isSelected
        iconImageView.image = isSelected ? category.normalImage : category.selectedImage
        titleLabel.textColor = isSelected ? UIColor.Gray.main : UIColor.white
    }

}
