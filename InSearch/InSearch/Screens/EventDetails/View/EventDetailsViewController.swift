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
    
    public var event: Event?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
        removeNavigationBarBackground()
        
        if let event = self.event {
            configureView(with: event)
        }
    }
    
    // MARK: - Private helpers
    
    private func configureView(with event: Event) {
        let adapter = EventDetailsTableViewAdapter(event: event, tableView: tableView)
        tableView.delegate = adapter
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
