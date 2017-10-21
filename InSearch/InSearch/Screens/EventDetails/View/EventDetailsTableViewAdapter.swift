//
//  EventDetailsTableViewAdapter.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventDetailsTableViewAdapter: NSObject {
    
    enum CellType {
        case header
        case description
        case field(String)
        
        var cellClass: String {
            switch self {
            case .header: return "EventDetailsHeaderTableViewCell"
            case .description: return "EventDescriptionTableViewCell"
            case .field(_): return "EventDescriptionTableViewCell"
            }
        }
    }
    
    // MARK: - Constants

    // MARK: - Properties
    
    fileprivate var event: Event
    fileprivate (set) var tableView: UITableView
    fileprivate var cellTypes: [CellType]
    
    // MARK: - Initialization and deinitialization
    
    init(event: Event, tableView: UITableView) {
        self.event = event
        self.tableView = tableView
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CellType.header.cellClass, bundle: nil), forCellReuseIdentifier: CellType.header.cellClass)
        tableView.register(UINib(nibName: CellType.description.cellClass, bundle: nil), forCellReuseIdentifier: CellType.description.cellClass)

        
        cellTypes = [
            .header,
            .description
        ]
    }
    
    // MARK: - Cells generation
    
    fileprivate func getHeaderCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.header.cellClass, for: indexPath) as! EventDetailsHeaderTableViewCell
        
        let model = EventDetailsHeaderTableViewCell.Model(imageURL: "https://kudago.com/media/thumbs/xl/images/event/52/74/5274e20a71af854d3664cdfbbcbaa0ab.jpg", title: "Вечер живого джаза в Музее советских игровых автоматов", actionTitle: "Пригласить")
        
        cell.configure(with: model)
        
        return cell
    }
    
    fileprivate func getDescriptionCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.description.cellClass, for: indexPath) as! EventDescriptionTableViewCell
        
        let model = EventDescriptionTableViewCell.Model(description: "Не пропустите вечер живого джаза в Музее советских игровых автоматов — вот где свобода самовыражения! Организаторы придерживаются правила «Главное — атмосфера», поэтому обстановка здесь очень душевная. Коллективы виртуозно импровизируют на радость публике.")
        
        cell.configure(with: model)
        
        return cell
    }
}
    
    
// MARK: - UITableViewDataSource

extension EventDetailsTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.cellTypes[indexPath.row]
        
        let cell = {() -> UITableViewCell in
            switch cellType {
            case .header: return self.getHeaderCell(tableView, indexPath: indexPath)
            case .description: return self.getDescriptionCell(tableView, indexPath: indexPath)
            case .field(_): return self.getDescriptionCell(tableView, indexPath: indexPath)
            }
        }()
        
        cell.selectionStyle = .none
        return cell
    }
}


// MARK: - UITableViewDelegate

extension EventDetailsTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


