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
    
    // MARK: - IBActions
    
    @IBAction func inviteButtonAction(_ sender: Any) {
        changeViews()
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
    
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
    
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
        static let topViewTopPadding: CGFloat = 16.0
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
    }
    
    // MARK: - Properties
    
    private var topView: UIView?
    private var midView: UIView?
    private var bottomView: UIView?
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    // MARK: - Private helpers
    
    private func setupInitialState() {
        edgesForExtendedLayout = []
        addBottomView()
        addMidView()
        addTopView()
        inviteButton.round(to: Constants.inviteButtonCornerRadius)
        inviteButton.setTitle(L10n.Pickerview.inviteButtonTitle, for: .normal)
        dislikeButton.roundSquare()
        dislikeButton.addBorder(width: Constants.circleButtonBorderWidth, color: UIColor.Gray.light)
        likeButton.roundSquare()
        likeButton.addBorder(width: Constants.circleButtonBorderWidth, color: UIColor.Gray.light)
    }
    
    /// Добавляет в первую вьюшку
    private func addTopView() {
        topView = UIView()
        topView?.backgroundColor = UIColor.Red.main
        guard let topView = topView else { return }
        self.view.insertSubview(topView, at: CardPosition.top.rawValue)
        configure(topView)
    }
    
    /// Добавляет вторую вьюшку
    private func addMidView() {
        midView = UIView()
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
        configure(midView)
    }
    
    /// Добавляет третью вьюшку
    private func addBottomView() {
        bottomView = UIView()
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
        configure(bottomView)
    }
    
    /// Добавляет лейблы возраста и имени ко вьюшке
    ///
    /// - Parameter view: вью
    private func addLabels(to view: UIView) {
        let ageLabel = UILabel()
        let nameLabel = UILabel()
        ageLabel.text = "21 год"
        nameLabel.text = "Алиса"
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
                constant: -Constants.labelHorizontalPadding
            ),
            nameLabel.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -Constants.nameLabelBottomPadding
            )
        ])
    }
    
    /// Добавляет кнопку для перехода к профилю пользователя
    ///
    /// - Parameter view: вью
    private func addProfileButton(to view: UIView) {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "img_picker_view_disclosure"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: Constants.nameLabelBottomPadding,
                                                left: Constants.nameLabelBottomPadding,
                                                bottom: Constants.nameLabelBottomPadding,
                                                right: Constants.nameLabelBottomPadding)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    /// Конфигурирует вьюшку
    ///
    /// - Parameter view: вью для конфигурации
    private func configure(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.round(to: Constants.cardViewCornerRadius)
        view.addShadow(opacity: Constants.cardViewCornerShadowOpacity)
        setupConstraints(to: view)
        addLabels(to: view)
        addProfileButton(to: view)
        addPhotoSlider(to: view)
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
    /// - Parameter view: вью
    private func addPhotoSlider(to view: UIView) {
        let photoSlider = PhotoSlider.instanceFromNib()
        photoSlider.frame = view.bounds
        photoSlider.configure(with: ["", "", ""])
        view.addSubview(photoSlider)
    }
    
    /// Перестановка вьюшек
    private func changeViews() {
        guard let midViewTransform = self.midView?.transform else { return }
        topView?.isHidden = true
        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: { [weak self] in
                self?.midView?.transform = CGAffineTransform.default
            },
            completion: { [weak self] _ in
                UIView.animate(
                    withDuration: Constants.animationDuration,
                    animations: { [weak self] in
                        self?.bottomView?.transform = midViewTransform
                    },
                    completion: { [weak self] _ in
                        self?.topView?.removeFromSuperview()
                        self?.topView = self?.midView
                        self?.midView = self?.bottomView
                        self?.addBottomView()
                        self?.bottomView?.alpha = 0
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
