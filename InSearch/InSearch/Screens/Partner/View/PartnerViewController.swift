//
//  PartnerViewController.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PartnerViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var user: User?
    var didTapOnLikeButton: VoidClosure?
    var didTapOnDislikeButton: VoidClosure?
    private var adapter: PartnerTableViewAdapter?
    
    
    // MARK: - UIViewController
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        removeNavigationBarBackground()
        if let user = self.user {
            configureView(with: user)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = nil
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Private helpers
    
    /// Конфигурация вью
    ///
    /// - Parameter user: пользователь
    private func configureView(with user: User) {
        let adapter = PartnerTableViewAdapter(user: user, tableView: tableView)
        adapter.didTapOnLikeButtonBlock = { [weak self] in
            guard let id = user.id else { return }
            UserService.postLikes(id: id, completion: { _ in })
            self?.didTapOnLikeButton?()
        }
        adapter.didTapOnDislikeButtonBlock = { [weak self] in
            self?.didTapOnDislikeButton?()
        }
        adapter.didTapOnInviteButtonBlock = { [weak self] in
            guard let currentUser = self?.user else { return }
            self?.openEventsScreen(with: currentUser)
        }
        adapter.didTapOnChatButtonBlock = { [weak self] in
            self?.openChatScreen()
        }
        tableView.dataSource = adapter
        self.adapter = adapter
        tableView.reloadData()
    }
    
    /// Начальное состояние контроллера
    private func setupInitialState() {
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    /// Убирает фон навбара
    private func removeNavigationBarBackground() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    /// Переход на экран списка событий
    ///
    /// - Parameter user: Пользователь, которого собираемся пригласить
    private func openEventsScreen(with user: User) {
        let eventsViewController = EventsViewController()
        eventsViewController.user = user
        self.navigationController?.pushViewController(eventsViewController, animated: true)
    }
    
    /// Переход на экран чата
    private func openChatScreen() {
        let chatViewController = ChatViewController()
        chatViewController.user = self.user
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}
