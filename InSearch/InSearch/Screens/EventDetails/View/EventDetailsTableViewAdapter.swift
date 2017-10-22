//
//  EventDetailsTableViewAdapter.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventDetailsTableViewAdapter: NSObject {
    
    typealias ActionButtonCallback = (() -> Void)
    
    enum CellType {
        case header
        case description
        case fieldEmpty
        case field(EventFieldTableViewCell.Model)
        
        var cellClass: String {
            switch self {
            case .header: return "EventDetailsHeaderTableViewCell"
            case .description: return "EventDescriptionTableViewCell"
            case .fieldEmpty, .field(_): return "EventFieldTableViewCell"
            }
        }
    }
    
    // MARK: - Constants

    // MARK: - Properties
    
    fileprivate var event: Event
    fileprivate (set) var tableView: UITableView
    fileprivate var cellTypes: [CellType]
    
    public var actionButtonCallback: ActionButtonCallback?
    
    // MARK: - Initialization and deinitialization
    
    init(event: Event, tableView: UITableView) {
        self.event = event
        self.tableView = tableView
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CellType.header.cellClass, bundle: nil), forCellReuseIdentifier: CellType.header.cellClass)
        tableView.register(UINib(nibName: CellType.description.cellClass, bundle: nil), forCellReuseIdentifier: CellType.description.cellClass)
        tableView.register(UINib(nibName: CellType.fieldEmpty.cellClass, bundle: nil), forCellReuseIdentifier: CellType.fieldEmpty.cellClass)

        
        var resultTypes: [CellType] = [
            .header,
            .description
        ]
        
        if let fields = event.fields?.map({CellType.field(EventFieldTableViewCell.Model(with: $0))}) {
            resultTypes.append(contentsOf: fields)
        }
        
        self.cellTypes = resultTypes
    }
    
    // MARK: - Cells generation
    
    fileprivate func getHeaderCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.header.cellClass, for: indexPath) as! EventDetailsHeaderTableViewCell
        
        let model = EventDetailsHeaderTableViewCell.Model(with: self.event)
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    fileprivate func getDescriptionCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.description.cellClass, for: indexPath) as! EventDescriptionTableViewCell
        
        let model = EventDescriptionTableViewCell.Model(with: self.event)
        
        cell.configure(with: model)
        
        return cell
    }
    
    fileprivate func getFieldCell(_ tableView: UITableView,  indexPath: IndexPath, model: EventFieldTableViewCell.Model) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.fieldEmpty.cellClass, for: indexPath) as! EventFieldTableViewCell
        
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
            case let .field(model): return self.getFieldCell(tableView, indexPath: indexPath, model: model)
            default: return UITableViewCell()
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

// MARK: - EventDetailsHeaderTableViewCellDelegate

extension EventDetailsTableViewAdapter: EventDetailsHeaderTableViewCellDelegate {
    func eventDetailsHeaderCellDidPressedActionButton(_ eventCell: EventDetailsHeaderTableViewCell) {
        self.actionButtonCallback?()
    }
}


