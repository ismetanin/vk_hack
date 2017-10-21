//
//  EventsViewController.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var pageSelectorCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var pageSelectorBackgroundView: UIVisualEffectView!
    
    // MARK: - Properties
    
    fileprivate var events: [Event] = []
    fileprivate var pageModels: [PageModel] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.events = [
            Event(JSON: [
                "id": "123",
                "title": "124254242",
                "type": "cinema"
                ])!
        ]
        
        self.pageModels = [
            PageModel(image: #imageLiteral(resourceName: "icon_cinema"), title: "Кино"),
            PageModel(image: #imageLiteral(resourceName: "icon_food"), title: "Еда"),
            PageModel(image: #imageLiteral(resourceName: "icon_concert"), title: "Концерты"),
            PageModel(image: #imageLiteral(resourceName: "icon_humor"), title: "Юмор"),
            PageModel(image: #imageLiteral(resourceName: "icon_culture"), title: "Культура"),
            PageModel(image: #imageLiteral(resourceName: "icon_games"), title: "Игры"),
            PageModel(image: #imageLiteral(resourceName: "icon_sport"), title: "Спорт"),
            PageModel(image: #imageLiteral(resourceName: "icon_festival"), title: "Фестивали")
        ]
        
        self.configurePageSelectorCollectionView()
        
        self.pageSelectorCollectionView.reloadData()
    }
    
    // MARK: - Private
    
    private func configurePageSelectorCollectionView() {
    
        self.pageSelectorCollectionView.backgroundColor = .clear
        self.pageSelectorCollectionView.delegate = self
        self.pageSelectorCollectionView.dataSource = self
        self.pageSelectorCollectionView.register(UINib(nibName:"PageIndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageIndicatorCollectionViewCell")
        self.pageSelectorCollectionView.showsVerticalScrollIndicator = false
        self.pageSelectorCollectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        layout.itemSize = CGSize(width: 66.0, height: 55.0)
        
        self.pageSelectorCollectionView.collectionViewLayout = layout
    }
    
    private func configureEventsCollectionView() {
        
        self.eventsCollectionView.backgroundColor = .clear
        self.eventsCollectionView.delegate = self
        self.eventsCollectionView.dataSource = self
        self.eventsCollectionView.register(UINib(nibName:"EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.eventsCollectionView.showsVerticalScrollIndicator = false
        self.eventsCollectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.pageSelectorCollectionView.collectionViewLayout = layout
    }
    
    fileprivate func getPageSelectorCell(_ collectionView: UICollectionView, fotItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageIndicatorCollectionViewCell", for: indexPath) as! PageIndicatorCollectionViewCell
        let model = pageModels[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    fileprivate func getEventCell(_ collectionView: UICollectionView, fotItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let model = events[indexPath.item]
//        cell.configure(with: model)
        return cell
    }

}

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.pageSelectorCollectionView {
            return self.getPageSelectorCell(collectionView, fotItemAt: indexPath)
        } else if collectionView == self.eventsCollectionView {
            return self.getEventCell(collectionView, fotItemAt: indexPath)
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.pageSelectorCollectionView {
            return self.pageModels.count
        } else if collectionView == self.eventsCollectionView {
            return self.events.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
