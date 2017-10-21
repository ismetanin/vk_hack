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
        static let topViewBottomPadding: CGFloat = -72.0
        static let topViewHorizontalPadding: CGFloat = 32.0
        static let midViewScale: CGFloat = 0.89
        static let midViewX: CGFloat = 8.0 * 100 / Constants.topViewHorizontalPadding
        static let bottomViewScale: CGFloat = 0.7
        static let bottomViewX: CGFloat = 24.0 * 100 / Constants.topViewHorizontalPadding
        static let animationDuration: TimeInterval = 0.2
    }
    
    // MARK: - Properties
    
    /// Первая вью
    private var topView: UIView?
    /// Вторая вью
    private var midView: UIView?
    /// Третья вью
    private var bottomView: UIView?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        addBottomView()
        addMidView()
        addTopView()
    }

    // MARK: - Internal helpers

    
    // MARK: - Private helpers
    
    /// Добавляет в первую вьюшку
    private func addTopView() {
        topView = UIView()
        guard let topView = topView else { return }
        self.view.insertSubview(topView, at: CardPosition.top.rawValue)
        configure(topView)
    }
    
    /// Добавляет вторую вьюшку
    private func addMidView() {
        midView = UIView()
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
    
    /// Конфигурирует вьюшку
    ///
    /// - Parameter view: вью для конфигурации
    private func configure(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.round(to: 10)
        setupConstraints(to: view)
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
    
    private func addPhotoSlider(to view: UIView) {
        let photoSlider = PhotoSlider.instanceFromNib()
        photoSlider.frame = view.bounds
        photoSlider.configure(with: [])
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
                        self?.bottomView?.backgroundColor = .blue
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
