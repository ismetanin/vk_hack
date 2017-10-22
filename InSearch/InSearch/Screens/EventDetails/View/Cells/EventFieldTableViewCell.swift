//
//  EventFieldTableViewCell.swift
//  InSearch
//
//  Created by Gregory Berngardt on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventFieldTableViewCell: UITableViewCell {

    struct Model {
        let title: String
        let value: String
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var fieldLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - IBActions
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fieldLabel.numberOfLines = 0
    }
    
    // MARK: - Public
    
    public func configure(with model: Model) {
        
        // title
        let titleString = "\(model.title): "
        let titleAttributes = [
            NSForegroundColorAttributeName: UIColor.Gray.text,
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
        ]
        let titleAttrString = NSAttributedString(string: titleString, attributes: titleAttributes)
        
        // value
        let valueAttributes = [
            NSForegroundColorAttributeName: UIColor.Black.text,
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
        ]
        let valueAttrString = NSAttributedString(string: model.value, attributes: valueAttributes)
        
        let resultAttrString = NSMutableAttributedString(attributedString: titleAttrString)
        resultAttrString.append(valueAttrString)
        
        self.fieldLabel.attributedText = resultAttrString
    }
    
}

extension EventFieldTableViewCell.Model {
    init(with field: Event.Field) {
        self.title = field.name ?? ""
        self.value = field.value ?? ""
    }
}
