//
//  EventDetailsTableViewAdapter.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventDetailsTableViewAdapter: NSObject {
    
    // MARK: - Constants
    
    fileprivate let headerCellName: String = "EventDetailsHeaderTableViewCell"
    
    // MARK: - Properties
    
    fileprivate var event: Event
    fileprivate (set) var tableView: UITableView
    fileprivate var cellsCount: Int {
        return 1
    }
    
    // MARK: - Initialization and deinitialization
    
    init(event: Event, tableView: UITableView) {
        self.event = event
        self.tableView = tableView
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: headerCellName, bundle: nil), forCellReuseIdentifier: headerCellName)
    }
    
    // MARK: - Cells generation
    
    fileprivate func getHeaderCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCellName, for: indexPath) as! EventDetailsHeaderTableViewCell
        
        let model = EventDetailsHeaderTableViewCell.Model(imageURL: "https://kudago.com/media/thumbs/xl/images/event/52/74/5274e20a71af854d3664cdfbbcbaa0ab.jpg", title: "Вечер живого джаза в Музее советских игровых автоматов", actionTitle: "Пригласить")
        
        cell.configure(with: model)
        
        return cell
    }
}
    
    
// MARK: - UITableViewDataSource

extension EventDetailsTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.getHeaderCell(tableView, indexPath: indexPath)
        
        cell.selectionStyle = .none
        return cell
    }
}


// MARK: - UITableViewDelegate

extension EventDetailsTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


