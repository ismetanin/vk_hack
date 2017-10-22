//
//  EventDetailsHeaderTableViewCell.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

protocol EventDetailsHeaderTableViewCellDelegate: class {
    func eventDetailsHeaderCellDidPressedActionButton(_ eventCell: EventDetailsHeaderTableViewCell)
}

class EventDetailsHeaderTableViewCell: UITableViewCell {

    struct Model {
        let imageURL: String
        let title: String
        let actionTitle: String
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var actionButton: RoundedButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    weak var delegate: EventDetailsHeaderTableViewCellDelegate?
    
    // MARK: - IBActions
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        self.delegate?.eventDetailsHeaderCellDidPressedActionButton(self)
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerImageView.contentMode = .scaleAspectFill
        self.headerImageView.clipsToBounds = true
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
        self.titleLabel.textColor = UIColor.Black.text
        
        self.actionButton.backgroundColor = UIColor.Red.main
        self.actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public
    
    public func configure(with model: Model) {
        self.actionButton.setTitle(model.actionTitle, for: .normal)
        self.headerImageView.setImage(withUrlString: model.imageURL, placeholderImage: nil)
        self.titleLabel.text = model.title
    }
    
}

extension EventDetailsHeaderTableViewCell.Model {
    init(with event: Event) {
        self.actionTitle = L10n.Pickerview.inviteButtonTitle
        self.imageURL = event.image ?? ""
        self.title = event.title ?? ""
    }
}
