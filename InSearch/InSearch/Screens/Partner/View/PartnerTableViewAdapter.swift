//
//  PartnerTableViewAdapter.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PartnerTableViewAdapter: NSObject {
    
    // MARK: - Enums
    
    enum CellType {
        case slider
        case name
        case interests
        case actions
        case fieldEmpty
        case field(EventFieldTableViewCell.Model)
        
        // MARK: - Properties
        
        var cellClass: String {
            switch self {
            case .slider: return "PartnerPhotoSliderTableViewCell"
            case .name: return "PartnerNameTableViewCell"
            case .interests: return "PartnerInterestsTableViewCell"
            case .actions: return "PartnerActionsTableViewCell"
            case .fieldEmpty, .field(_): return "EventFieldTableViewCell"
            }
        }
    }
        
    // MARK: - Properties
    
    var didTapOnInviteButtonBlock: VoidClosure?
    var didTapOnChatButtonBlock: VoidClosure?
    var didTapOnDislikeButtonBlock: VoidClosure?
    var didTapOnLikeButtonBlock: VoidClosure?
    fileprivate var user: User
    fileprivate (set) var tableView: UITableView
    fileprivate var cellTypes: [CellType]
    
    // MARK: - Initialization and deinitialization
    
    init(user: User, tableView: UITableView) {
        self.user = user
        self.tableView = tableView
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CellType.slider.cellClass, bundle: nil), forCellReuseIdentifier: CellType.slider.cellClass)
        tableView.register(UINib(nibName: CellType.name.cellClass, bundle: nil), forCellReuseIdentifier: CellType.name.cellClass)
        tableView.register(UINib(nibName: CellType.interests.cellClass, bundle: nil), forCellReuseIdentifier: CellType.interests.cellClass)
        tableView.register(UINib(nibName: CellType.actions.cellClass, bundle: nil), forCellReuseIdentifier: CellType.actions.cellClass)
        tableView.register(UINib(nibName: CellType.fieldEmpty.cellClass, bundle: nil), forCellReuseIdentifier: CellType.fieldEmpty.cellClass)
        
        cellTypes = [
            .slider,
            .name,
            .interests,
            .actions,
            .field(EventFieldTableViewCell.Model(title: "Возраст", value: "21")),
            .field(EventFieldTableViewCell.Model(title: "Рост", value: "165")),
            .field(EventFieldTableViewCell.Model(title: "Вес", value: "55")),
            .field(EventFieldTableViewCell.Model(title: "Цвет глаз", value: "Голубые")),
        ]
    }
    
    // MARK: - Cells generation
    
    fileprivate func getSliderCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.slider.cellClass, for: indexPath) as! PartnerPhotoSliderTableViewCell
        
        if let urlStrings = user.avatarURLStrings {
            cell.configure(with: urlStrings)
        }
        
        return cell
    }
    
    fileprivate func getNameCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.name.cellClass, for: indexPath) as! PartnerNameTableViewCell
        
        cell.configure(name: user.name, city: user.city)
        
        return cell
    }
    
    fileprivate func getInterestsCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.interests.cellClass, for: indexPath) as! PartnerInterestsTableViewCell
        
        cell.configure()
        
        return cell
    }
    
    fileprivate func getActionsCell(_ tableView: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.actions.cellClass, for: indexPath) as! PartnerActionsTableViewCell
        
        cell.configure(mutually: user.isMutually ?? false)
        
        cell.didTapOnLikeButtonBlock = { [weak self] in self?.didTapOnLikeButtonBlock?() }
        cell.didTapOnDislikeButtonBlock = { [weak self] in self?.didTapOnDislikeButtonBlock?() }
        cell.didTapOnInviteButtonBlock = { [weak self] in self?.didTapOnInviteButtonBlock?() }
        cell.didTapOnChatButtonBlock = { [weak self] in self?.didTapOnChatButtonBlock?() }
        
        return cell
    }
    
    fileprivate func getFieldCell(_ tableView: UITableView,  indexPath: IndexPath, model: EventFieldTableViewCell.Model) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.fieldEmpty.cellClass, for: indexPath) as! EventFieldTableViewCell
        
        cell.configure(with: model)
        
        return cell
    }
}


// MARK: - UITableViewDataSource

extension PartnerTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.cellTypes[indexPath.row]
        
        let cell = {() -> UITableViewCell in
            switch cellType {
            case .slider: return self.getSliderCell(tableView, indexPath: indexPath)
            case .name: return self.getNameCell(tableView, indexPath: indexPath)
            case .interests: return self.getInterestsCell(tableView, indexPath: indexPath)
            case .actions: return self.getActionsCell(tableView, indexPath: indexPath)
            case let .field(model): return self.getFieldCell(tableView, indexPath: indexPath, model: model)
            default: return UITableViewCell()
            }
        }()
        
        cell.selectionStyle = .none
        return cell
    }
}
