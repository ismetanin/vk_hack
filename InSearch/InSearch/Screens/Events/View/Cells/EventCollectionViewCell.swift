//
//  EventCollectionViewCell.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    struct Model {
        let imageURL: String?
        let title: String
        let description: String
        let score: Float
        let actionTitle: String
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var actionButton: RoundedButton!
    
    // MARK: - Properties
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
        self.titleLabel.textColor = UIColor.Black.text
        
        self.scoreLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
        self.scoreLabel.textColor = UIColor.Black.text
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular)
        self.descriptionLabel.textColor = UIColor.Gray.text
        
        self.actionButton.backgroundColor = UIColor.Red.main
        self.actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
        
        self.configureCellStyle()
    }
    
    // MARK: - Public
    
    public func configure(with model: Model) {
        self.actionButton.setTitle(model.actionTitle, for: .normal)
        self.imageView.setImage(withUrlString: model.imageURL, placeholderImage: nil)
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.scoreLabel.text = NSString(format: "%.01f", model.score) as String
        
    }
    
    // MARK: - Private
    
    private func configureShadow() {
        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    private func configureCellStyle() {
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
        
        self.configureShadow()
    }

}
