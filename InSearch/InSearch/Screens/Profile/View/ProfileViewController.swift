//
//  ProfileViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func exitButtonAction(_ sender: Any) {
        
    }
    
    // MARK: - Constants
    
    private let exitButtonCornerRadius: CGFloat = 26.0
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        loadProfile()
    }

    // MARK: - Private helpers
    
    /// Устанавливает первоначальное состояние вью
    private func setupInitialState() {
        avatarImageView.roundSquare()
        exitButton.round(to: exitButtonCornerRadius)
        exitButton.setTitle(L10n.Profileview.exitButtonTitle, for: .normal)
    }
    
    /// Загружает профиль пользователя
    private func loadProfile() {
        ProfileService.getProfile { [weak self] result in
            guard let value = result.value else { return }
            self?.configure(with: value.value)
        }
    }
    
    /// Конфигурирует экран
    ///
    /// - Parameter user: профиль пользователя
    private func configure(with user: User) {
        avatarImageView.setImage(withUrlString: user.avatarURLStrings?.first, placeholderImage: nil)
        let age = user.age?.getWordForPluralNumber(
            with: [
                L10n.Pickerview.ageLabelNominative,
                L10n.Pickerview.ageLabelGenitiveSingular,
                L10n.Pickerview.ageLabelGenitivePlural
            ]
        )
        nameAgeLabel.text = (user.name ?? "") + ", " + (age ?? "")
        locationImageView.image = user.city != nil ? #imageLiteral(resourceName: "img_partner_locaion") : nil
        locationLabel.text = user.city
    }
}
