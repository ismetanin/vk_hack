//
//  SelectFavorsViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class SelectFavorsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - IBActions

    @IBAction private func doneButtonAction(_ sender: UIButton) {

    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        DispatchQueue.main.sync {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "google.com")!)
            } else {
                UIApplication.shared.openURL(URL(string: "google.com")!)
            }
        }
    }

    // MARK: - Internal helpers

}

import UIKit

protocol SelectFavorsViewAdapterOutput {

}

final class SelectFavorsTableViewAdapter: NSObject {

    // MARK: - Constants

//    fileprivate let output: SelectFavorsViewAdapterOutput

    // MARK: - Properties

    fileprivate var items: [String]
    fileprivate (set) var tableView: UITableView {
        didSet {
            tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")
        }
    }

    // MARK: - Initialization and deinitialization

    init(items: [String], tableView: UITableView) {
        self.items = items
        self.tableView = tableView
    }

}


// MARK: - UITableViewDataSource

extension SelectFavorsTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}


// MARK: - UITableViewDelegate

extension SelectFavorsTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[0] = "kek"
    }
}
