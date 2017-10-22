//
//  EventDescriptionTableViewCell.swift
//  InSearch
//
//  Created by Gregory Berngardt on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventDescriptionTableViewCell: UITableViewCell {

    struct Model {
        let description: String
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - IBActions
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        self.descriptionLabel.textColor = UIColor.Gray.text
        self.descriptionLabel.numberOfLines = 0
    }
    
    // MARK: - Public
    
    public func configure(with model: Model) {
        self.descriptionLabel.text = model.description
    }
    
}

extension EventDescriptionTableViewCell.Model {
    init(with event: Event) {
        self.description = event.summary ?? ""
    }
}
