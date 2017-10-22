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
    
    // MARK: - Private helpers
    
    private func configureView(with user: User) {
        let adapter = PartnerTableViewAdapter(user: user, tableView: tableView)
        adapter.didTapOnLikeButtonBlock = {
            guard let id = user.id else { return }
            UserService.postLikes(id: id, completion: { _ in })
        }
        adapter.didTapOnDislikeButtonBlock = { [weak self] in
            self?.didTapOnDislikeButton?()
            self?.navigationController?.popViewController(animated: true)
        }
        adapter.didTapOnInviteButtonBlock = {  }
        adapter.didTapOnChatButtonBlock = {  }
        tableView.dataSource = adapter
        self.adapter = adapter
        tableView.reloadData()
    }
    
    private func setupInitialState() {
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func removeNavigationBarBackground() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = .white
    }
}
