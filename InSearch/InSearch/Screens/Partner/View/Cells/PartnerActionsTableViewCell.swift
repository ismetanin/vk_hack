//
//  PartnerActionsTableViewCell.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PartnerActionsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - IBActions
    
    @IBAction func inviteButtonAction(_ sender: Any) {
        didTapOnInviteButtonBlock?()
    }
    
    @IBAction func chatButtonAction(_ sender: Any) {
        didTapOnChatButtonBlock?()
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        didTapOnDislikeButtonBlock?()
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        didTapOnLikeButtonBlock?()
        showChatButton()
        likeButton.addBorder(width: Constants.buttonBorderWidth, color: UIColor.Red.main)
    }
    
    // MARK: - Enums
    
    private enum Constants {
        static let ovalButtonCornerRadius: CGFloat = 28.0
        static let buttonBorderWidth: CGFloat = 1.0
    }
    
    // MARK: - Properties
    
    var didTapOnInviteButtonBlock: VoidClosure?
    var didTapOnChatButtonBlock: VoidClosure?
    var didTapOnDislikeButtonBlock: VoidClosure?
    var didTapOnLikeButtonBlock: VoidClosure?
    private var isMutually = false
    
    // MARK: - Internal helpers
    
    func configure(mutually: Bool) {
        setupInitialState()
        self.isMutually = mutually
        showChatButton()
    }
    
    // MARK: - Private helpers
    
    private func setupInitialState() {
        inviteButton.round(to: Constants.ovalButtonCornerRadius)
        inviteButton.setTitle(L10n.Pickerview.inviteButtonTitle, for: .normal)
        chatButton.round(to: Constants.ovalButtonCornerRadius)
        chatButton.addBorder(width: Constants.buttonBorderWidth, color: UIColor.Gray.light)
        chatButton.setTitle(L10n.Partnerview.chatButtonTitle, for: .normal)
        dislikeButton.roundSquare()
        dislikeButton.addBorder(width: Constants.buttonBorderWidth, color: UIColor.Gray.light)
        likeButton.roundSquare()
        likeButton.addBorder(width: Constants.buttonBorderWidth, color: UIColor.Gray.light)
    }
    
    private func showChatButton() {
        guard isMutually else { return }
        likeButton.isHidden = true
        dislikeButton.isHidden = true
        chatButton.isHidden = false
        stackView.spacing = 8
        stackView.distribution = .fillEqually
    }
}
