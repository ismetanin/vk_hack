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
        setupInitialState()

        let react1 = Reaction()
        let user1 = User()
        user1.name = "Александр"
        user1.avatarURLStrings = ["http://www.foodmatters.com/media/uploads/images/articles/pets-article.jpg"]
        react1.user = user1
        react1.mutually = true
        react1.timestamp = Date()

        let react2 = Reaction()
        let user2 = User()
        user2.name = "Петруччио Де Сантес"
        react2.user = user2
        react2.mutually = false
        react2.timestamp = Date()

        let react3 = Reaction()
        let user3 = User()
        user3.name = "Георгий"
        react3.user = user3
        react3.mutually = false
        react3.timestamp = Date()


        let adapter = NotifiesTableViewAdapter(
            items: [
                react1, react2, react3, react1, react2, react3, react1,
                react2, react3, react1, react2, react3, react1, react2,
                react3, react1, react2, react3, react1, react2, react3
                ],
            tableView: tableView,
            output: self
        )
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter = adapter
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private helpers

    private func setupInitialState() {
        tableView.estimatedRowHeight = 82.5
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

// MARK: - NotifiesViewAdapterOutput
extension NotifiesViewController: NotifiesViewAdapterOutput {
    func didSelectReaction(reaction: Reaction) {
        // todo: transition
    }
}
