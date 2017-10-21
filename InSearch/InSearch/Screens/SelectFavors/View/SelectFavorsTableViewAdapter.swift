//
//  SelectFavorsTableViewAdapter.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class SelectFavorsTableViewAdapter: NSObject {

    // MARK: - Constants

    fileprivate let favorsCellName: String = "FavorsTableViewCell"

    // MARK: - Properties

    fileprivate var items: [Category]
    fileprivate var isSelected: [Bool]
    fileprivate (set) var tableView: UITableView

    // MARK: - Initialization and deinitialization

    init(items: [Category], tableView: UITableView) {
        self.items = items
        self.isSelected = [Bool](repeating: false, count: items.count)
        self.tableView = tableView
        tableView.register(
            UINib(
                nibName: favorsCellName,
                bundle: nil
            ),
            forCellReuseIdentifier: favorsCellName
        )
    }

}


// MARK: - UITableViewDataSource

extension SelectFavorsTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: favorsCellName,
            for: indexPath
            ) as? FavorsTableViewCell
        cell?.fill(category: items[indexPath.row], isSelected: isSelected[indexPath.row])
        return cell ?? UITableViewCell()
    }
}


// MARK: - UITableViewDelegate

extension SelectFavorsTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
