//
//  NotifiesTableViewAdapter.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

protocol NotifiesViewAdapterOutput {
    func didSelectReaction(reaction: Reaction)
}

final class NotifiesTableViewAdapter: NSObject {

    // MARK: - Constants

    fileprivate let output: NotifiesViewAdapterOutput
    fileprivate let items: [Reaction]
    fileprivate let reactionCellName: String = "ReactionTableViewCell"

    // MARK: - Initialization and deinitialization

    init(items: [Reaction], tableView: UITableView, output: NotifiesViewAdapterOutput) {
        self.items = items
        self.output = output
        tableView.register(UINib(nibName: reactionCellName, bundle: nil), forCellReuseIdentifier: reactionCellName)
    }

}


// MARK: - UITableViewDataSource

extension NotifiesTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reactionCellName, for: indexPath) as? ReactionTableViewCell
        cell?.fill(with: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}


// MARK: - UITableViewDelegate

extension NotifiesTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.didSelectReaction(reaction: items[indexPath.row])
    }
}
