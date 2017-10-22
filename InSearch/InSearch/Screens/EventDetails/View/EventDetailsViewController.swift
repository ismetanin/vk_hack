//
//  EventDetailsViewController.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var adapter: EventDetailsTableViewAdapter?
    fileprivate var bufferedBarTintColor: UIColor?

    public var event: Event?
    public var user: User?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        setupInitialState()
        configureNavigationBarStyle()
        
        if let event = self.event {
            configureView(with: event)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBarStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.revertNavigationBarStyle()
    }
    
    // MARK: - Private helpers
    
    private func configureView(with event: Event) {
        let adapter = EventDetailsTableViewAdapter(event: event, tableView: tableView)
        
        adapter.actionButtonCallback = { () -> Void in
            self.openChatScreen()
        }
        
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter = adapter
        tableView.reloadData()
    }
    
    private func setupInitialState() {
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = false
    }
    
    private func configureNavigationBarStyle() {
        // Удаляем фон
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Изменяем цвет
        self.bufferedBarTintColor = self.navigationController?.navigationBar.tintColor
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func revertNavigationBarStyle() {
        self.navigationController?.navigationBar.tintColor = self.bufferedBarTintColor
    }
    
    private func openChatScreen() {
        let chatViewController = ChatViewController()
        chatViewController.user = self.user
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }

}
