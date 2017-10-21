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
        sendCategoriesAndCloseView()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        loadCategoriesAndSetupView()
    }

    // MARK: - Private helpers

    private func sendCategoriesAndCloseView() {
        guard let categories = adapter?.getSelectedCategories() else {
            return
        }
        let categoriesIds = categories.map { $0.id ?? "" }
        CategoriesService.sendCategories(ids: categoriesIds) { [weak self] (result) in
            if result.error == nil {
                // Set key that user set categories
                UserDefaults.standard.isCategoriesSet = true
                // Show main screen
                self?.showMainScreen()
            } else {
                // TODO: show error message
            }
        }
    }

    private func showMainScreen() {
        let tabBarController = TabBarController()

        if let window = UIApplication.shared.keyWindow {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    window.rootViewController = tabBarController
                },
                completion: nil
            )
        }
    }

    private func loadCategoriesAndSetupView() {
        CategoriesService.getCategoryList { [weak self] (result) in
            if let categories = result.value?.value {
                self?.configureView(with: categories)
            } else {
                // TODO: show error
            }
        }
    }

    private func configureView(with categories: [Category]) {
        let adapter = SelectFavorsTableViewAdapter(items: categories, tableView: tableView)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter = adapter
        tableView.reloadData()
    }

    private func setupInitialState() {
        fillStaticTexts()
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    private func fillStaticTexts() {
        titleLabel.text = L10n.Favors.title
        doneButton.setTitle(L10n.Favors.done, for: .normal)
    }
}
