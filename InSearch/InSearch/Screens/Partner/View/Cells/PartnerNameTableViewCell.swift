//
//  PartnerNameTableViewCell.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PartnerNameTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    // MARK: - Internal helpers
    
    func configure(name: String?, city: String?) {
        nameLabel.text = name
        cityLabel.text = city
        locationImageView.image = city != nil ? #imageLiteral(resourceName: "img_partner_locaion") : nil
    }
}
