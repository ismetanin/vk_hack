//
//  NotifiesViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class NotifiesViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    private var adapter: NotifiesTableViewAdapter?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        setupInitialState()
        configureView(with: [])
        loadReactionsAndSetupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadReactionsAndSetupView()
    }

    // MARK: - Private helpers

    private func configureView(with reactions: [Reaction]) {
        let adapter = NotifiesTableViewAdapter(items: reactions, tableView: tableView, output: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter = adapter
        tableView.reloadData()
    }
    
    private func setupInitialState() {
        tableView.estimatedRowHeight = 82.5
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadReactionsAndSetupView() {
        ReactionsService.getReactionsList { [weak self] (result) in
            if let reactions = result.value?.value {
                self?.configureView(with: reactions)
            } else {
                // TODO: show error
            }
        }
    }
    
    private func configureTitle() {
        self.title = L10n.Reactions.title
    }
}

// MARK: - NotifiesViewAdapterOutput
extension NotifiesViewController: NotifiesViewAdapterOutput {
    func didSelectReaction(reaction: Reaction) {
        // todo: transition
    }
}
