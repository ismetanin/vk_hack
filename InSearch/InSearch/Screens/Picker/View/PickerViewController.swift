//
//  PickerViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PickerViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func inviteButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        dislikeUser()
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        guard let id = topView?.user?.id else { return }
        UserService.postLikes(id: id) { [weak self] result in
            guard let _ = result.value else { return }
            self?.changeViews()
        }
    }
    
    // MARK: - Enums
    
    /// Позиция карточки
    ///
    /// - top: верхняя
    /// - mid: средняя
    /// - bottom: нижняя
    private enum CardPosition: Int {
        case top = 2
        case mid = 1
        case bottom = 0
    }
    
    private enum Constants {
        static let topViewTopPadding: CGFloat = 24.0
        static let topViewBottomPadding: CGFloat = -80.0
        static let topViewHorizontalPadding: CGFloat = 32.0
        static let midViewScale: CGFloat = 0.89
        static let midViewX: CGFloat = 8.0 * 100 / Constants.topViewHorizontalPadding
        static let bottomViewScale: CGFloat = 0.7
        static let bottomViewX: CGFloat = 24.0 * 100 / Constants.topViewHorizontalPadding
        static let animationDuration: TimeInterval = 0.2
        static let cardViewCornerRadius: CGFloat = 10.0
        static let cardViewCornerShadowOpacity: Float = 0.2
        static let inviteButtonCornerRadius: CGFloat = 28.0
        static let circleButtonBorderWidth: CGFloat = 1.0
        static let labelHorizontalPadding: CGFloat = 24.0
        static let ageLabelNameLabelPadding: CGFloat = -6.0
        static let nameLabelBottomPadding: CGFloat = 16.0
        static let ageLabelFontSize: CGFloat = 20.0
        static let nameLabelFontSize: CGFloat = 28.0
        static let nameLabelRightPadding: CGFloat = 32.0
    }
    
    // MARK: - Properties
    
    private var topView: CardView?
    private var midView: CardView?
    private var bottomView: CardView?
    private var users: [User]?
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        loadUsers()
    }
    
    // MARK: - Private helpers
    
    /// Загружает список пользователей
    private func loadUsers() {
        UserService.getUsers { [weak self] result in
            guard
                let `self` = self,
                let users = result.value?.value
            else {
                return
            }
            self.configure(with: users)
            self.emptyView.isHidden = !users.isEmpty
        }
    }
    
    /// Конфигурирует вью полученными модельными объектами
    ///
    /// - Parameter users: пользователи
    private func configure(with users: [User]) {
        self.users = users
        guard var newUsers = self.users else { return }
        if !newUsers.isEmpty {
            addTopView(with: newUsers[0])
            newUsers.removeFirst()
        }
        if !newUsers.isEmpty {
            addMidView(with: newUsers[0])
            newUsers.removeFirst()
        }
        if !newUsers.isEmpty {
            addBottomView(with: newUsers[0])
            newUsers.removeFirst()
        }
        self.users = newUsers
    }
    
    /// Конфигурирует начальное состояние экрана
    private func setupInitialState() {
        removeNavigationBarBackground()
        inviteButton.round(to: Constants.inviteButtonCornerRadius)
        inviteButton.setTitle(L10n.Pickerview.inviteButtonTitle, for: .normal)
        dislikeButton.roundSquare()
        dislikeButton.addBorder(width: Constants.circleButtonBorderWidth, color: UIColor.Gray.light)
        likeButton.roundSquare()
        likeButton.addBorder(width: Constants.circleButtonBorderWidth, color: UIColor.Gray.light)
        emptyViewLabel.text = L10n.Pickerview.emptyScreenLabel
    }
    
    /// Добавляет в первую вьюшку
    ///
    /// - Parameter user: пользователь
    private func addTopView(with user: User) {
        topView = CardView()
        topView?.user = user
        topView?.backgroundColor = UIColor.Red.main
        guard let topView = topView else { return }
        self.view.insertSubview(topView, at: CardPosition.top.rawValue)
        configure(topView, with: user)
    }
    
    /// Добавляет вторую вьюшку
    ///
    /// - Parameter user: пользователь
    private func addMidView(with user: User) {
        midView = CardView()
        midView?.user = user
        midView?.backgroundColor = UIColor.Red.main
        midView?.transform = CGAffineTransform(
            scaleX: Constants.midViewScale,
            y: Constants.midViewScale
        )
        .translatedBy(
            x: Constants.midViewX,
            y: 0
        )
        guard let midView = midView else { return }
        self.view.insertSubview(midView, at: CardPosition.mid.rawValue)
        configure(midView, with: user)
    }
    
    /// Добавляет третью вьюшку
    ///
    /// - Parameter user: пользователь
    private func addBottomView(with user: User) {
        bottomView = CardView()
        bottomView?.user = user
        bottomView?.backgroundColor = UIColor.Red.main
        bottomView?.transform = CGAffineTransform(
            scaleX: Constants.bottomViewScale,
            y: Constants.bottomViewScale
        )
        .translatedBy(
            x: Constants.bottomViewX,
            y: 0
        )
        guard let bottomView = bottomView else { return }
        self.view.insertSubview(bottomView, at: CardPosition.bottom.rawValue)
        configure(bottomView, with: user)
    }
    
    /// Добавляет лейблы возраста и имени ко вьюшке
    ///
    /// - Parameters:
    ///   - view: вью
    ///   - age: возраст пользователя
    ///   - name: имя пользователя
    private func addLabels(to view: UIView, age: Int?, name: String?) {
        let ageLabel = UILabel()
        let nameLabel = UILabel()
        ageLabel.text = age?.getWordForPluralNumber(
            with: [
                L10n.Pickerview.ageLabelNominative,
                L10n.Pickerview.ageLabelGenitiveSingular,
                L10n.Pickerview.ageLabelGenitivePlural
            ]
        )
        nameLabel.text = name
        ageLabel.font = UIFont.boldSystemFont(ofSize: Constants.ageLabelFontSize)
        nameLabel.font = UIFont.boldSystemFont(ofSize: Constants.nameLabelFontSize)
        ageLabel.textColor = .white
        nameLabel.textColor = .white
        view.addSubview(ageLabel)
        view.addSubview(nameLabel)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.labelHorizontalPadding
            ),
            ageLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.labelHorizontalPadding
            ),
            ageLabel.bottomAnchor.constraint(
                equalTo: nameLabel.topAnchor,
                constant: Constants.ageLabelNameLabelPadding
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.labelHorizontalPadding
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.nameLabelRightPadding
            ),
            nameLabel.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -Constants.nameLabelBottomPadding
            )
        ])
    }
    
    /// Конфигурирует вьюшку
    ///
    /// - Parameters:
    ///   - view: вью
    ///   - user: пользователь
    private func configure(_ view: UIView, with user: User) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.round(to: Constants.cardViewCornerRadius)
        view.addShadow(opacity: Constants.cardViewCornerShadowOpacity)
        setupConstraints(to: view)
        addPhotoSlider(to: view, photosURLs: user.avatarURLStrings ?? [])
        addLabels(to: view, age: user.age, name: user.name)
    }
    
    /// Устанавливает констреинты для вьюшек
    ///
    /// - Parameter view: вью
    private func setupConstraints(to view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: Constants.topViewTopPadding
            ),
            view.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: Constants.topViewBottomPadding
            ),
            view.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: Constants.topViewHorizontalPadding
            ),
            view.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -Constants.topViewHorizontalPadding
            )
        ])
    }
    
    /// Добавляет слайдер для фото пользователя во вью
    ///
    /// - Parameters:
    ///   - view: вью
    ///   - photosURSs: ссылки на фотографии
    private func addPhotoSlider(to view: UIView, photosURLs: [String]) {
        let photoSlider = PhotoSlider.instanceFromNib()
        view.clipsToBounds = true
        photoSlider.frame = view.bounds
        photoSlider.configure(with: photosURLs)
        photoSlider.didTapDisclosureButtonBlock = { [weak self] in
            let partnerViewController = PartnerViewController()
            partnerViewController.user = self?.topView?.user
            partnerViewController.didTapOnDislikeButton = { [weak self] in
                self?.dislikeUser()
            }
            self?.navigationController?.pushViewController(partnerViewController, animated: true)
        }
        view.addSubview(photoSlider)
    }
    
    /// Удаляет фон нав бара
    private func removeNavigationBarBackground() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    /// Ставит дизлайк пользователю
    private func dislikeUser() {
        guard let id = topView?.user?.id else { return }
        UserService.postDislikes(id: id) { [weak self] result in
            guard let _ = result.value else { return }
            self?.changeViews()
        }
    }
    
    /// Перестановка вьюшек
    private func changeViews() {
        self.dislikeButton.isEnabled = false
        self.likeButton.isEnabled = false
        guard
            let users = self.users
        else {
            self.dislikeButton.isEnabled = true
            self.likeButton.isEnabled = true
            return
        }
        topView?.isHidden = true
        let midViewTransform = self.midView?.transform
        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: { [weak self] in
                self?.midView?.transform = CGAffineTransform.default
            },
            completion: { [weak self] _ in
                UIView.animate(
                    withDuration: Constants.animationDuration,
                    animations: { [weak self] in
                        if let midViewTransform = midViewTransform{
                            self?.bottomView?.transform = midViewTransform
                        }
                    },
                    completion: { [weak self] _ in
                        self?.topView?.removeFromSuperview()
                        self?.topView = self?.midView
                        self?.midView = self?.bottomView
                        self?.bottomView = nil
                        guard users.count > 0
                        else {
                            self?.emptyView.isHidden = self?.topView != nil
                            self?.dislikeButton.isEnabled = true
                            self?.likeButton.isEnabled = true
                            return
                        }
                        self?.addBottomView(with: users[0])
                        self?.users?.removeFirst()
                        self?.bottomView?.alpha = 0
                        self?.dislikeButton.isEnabled = true
                        self?.likeButton.isEnabled = true
                        UIView.animate(
                            withDuration: Constants.animationDuration,
                            animations: { [weak self] in
                                self?.bottomView?.alpha = 1
                            }
                        )
                    }
                )
            }
        )
    }
}
