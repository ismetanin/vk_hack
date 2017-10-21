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
    var adapter: SelectFavorsTableViewAdapter?

    // MARK: - IBActions

    @IBAction private func doneButtonAction(_ sender: UIButton) {
        
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    // MARK: - Private helpers

    private func configureView(with categories: [Category]) {
        let adapter = SelectFavorsTableViewAdapter(items: categories, tableView: tableView)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter = adapter
    }

    private func setupInitialState() {
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    private func fillStaticTexts() {
        titleLabel.text = L10n.Favors.title
        doneButton.setTitle(L10n.Favors.done, for: .normal)
    }
}
