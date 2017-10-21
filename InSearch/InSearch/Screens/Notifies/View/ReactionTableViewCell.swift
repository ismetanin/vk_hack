//
//  ReactionTableViewCell.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class ReactionTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var reactionTypeLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var reactionTypeImageView: UIImageView!

    // MARK: - Internal methods

    func fill(with reaction: Reaction) {
        avatarImageView.setImage(
            withUrlString: reaction.user?.avatarURLStrings?.first,
            placeholderImage: nil
        )
        nameLabel.text = reaction.user?.name
        timeLabel.text = ""// format reaction.timestamp
        if reaction.mutually == true {
            reactionTypeImageView.image = #imageLiteral(resourceName: "img_mutual_like")
            reactionTypeLabel.text = L10n.Reactions.mutual
        } else {
            reactionTypeImageView.image = #imageLiteral(resourceName: "img_single_like")
            reactionTypeLabel.text = L10n.Reactions.single
        }
    }
}
