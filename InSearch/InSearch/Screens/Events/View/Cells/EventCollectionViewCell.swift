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
    
    // MARK: - Properties
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Public
    
    public func configure(with: Model) {
        
    }

}
