//
//  PageIndicatorCollectionViewCell.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

struct PageModel {
    let image: UIImage
    let title: String
}

class PageIndicatorCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    override var isHighlighted: Bool {
        didSet {
            actualizeCellState()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            actualizeCellState()
        }
    }
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightMedium)
        
        actualizeCellState()
    }
    
    // MARK: - Private
    
    private func actualizeCellState() {
        let selectedColor = UIColor(red: 0.96, green: 0.26, blue: 0.16, alpha: 1)
        let normalColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        let highlightColor = UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1)
        
        let resultColor = { () -> UIColor in
            let state = (isSelected, isHighlighted)
            switch state {
                case (true, true): return selectedColor
                case (true, false): return selectedColor
                case (false, true): return highlightColor
                case (false, false): return normalColor
            }
        }()
        
        imageView.image = imageView.image?.image(withTintColor: resultColor)
        titleLabel.textColor = resultColor
    }
    
    // MARK: - Public
    
    public func configure(with model: PageModel) {
        imageView?.image = model.image
        titleLabel?.text = model.title
    }

}
