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
    
    fileprivate var eventsModels: [EventCollectionViewCell.Model] = []
    fileprivate var pageModels: [PageModel] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.events = [
//            Event(JSON: [
//                "id": "123",
//                "title": "124254242",
//                "type": "cinema"
//                ])!
//        ]
//
        self.eventsModels = [
            EventCollectionViewCell.Model(imageURL: "https://kudago.com/media/thumbs/xl/images/event/52/74/5274e20a71af854d3664cdfbbcbaa0ab.jpg",title: "Вечер живого джаза в Музее советских игровых автоматов", description: "Не пропустите вечер живого джаза в Музее советских игровых автоматов — вот где свобода самовыражения! Организаторы придерживаются правила «Главное — атмосфера», поэтому обстановка здесь очень душевная. Коллективы виртуозно импровизируют на радость публике.", score: 4.0, actionTitle: "Пригласить"),
            EventCollectionViewCell.Model(imageURL: "https://kudago.com/media/thumbs/xl/images/place/38/c1/38c1405ab5a79abb29fa2e7ef1d326ad.jpg",title: "Игра в реальности «Прятки в темноте»", description: "Захватывающее развлечение для смельчаков и любителей острых ощущений приготовила компания «Страшнотемно». Призраки вышли на охоту и ищут заблудившихся в ночи людей. Интригует? Не то слово! Но вам должно понравиться.", score: 4.7, actionTitle: "Пригласить")
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
        self.configureEventsCollectionView()
        
        self.eventsCollectionView.reloadData()
        self.pageSelectorCollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updatePageSelectorCollectionViewLayout()
        self.updateEventsCollectionViewLayout()
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
    
    private func updatePageSelectorCollectionViewLayout() {
        if let layout = self.pageSelectorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
            layout.itemSize = CGSize(width: 66.0, height: 55.0)
        }
    }
    
    private func configureEventsCollectionView() {
        
        self.eventsCollectionView.backgroundColor = .clear
        self.eventsCollectionView.delegate = self
        self.eventsCollectionView.dataSource = self
        self.eventsCollectionView.register(UINib(nibName:"EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.eventsCollectionView.showsVerticalScrollIndicator = true
        self.eventsCollectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        layout.itemSize = CGSize(width: self.eventsCollectionView.bounds.width * 0.88, height: 316.0)
        
        self.eventsCollectionView.collectionViewLayout = layout
    }
    
    private func updateEventsCollectionViewLayout() {
        
        self.eventsCollectionView.contentInset = UIEdgeInsets(top: pageSelectorCollectionView.bounds.height, left: 0.0, bottom: self.eventsCollectionView.contentInset.bottom, right: 0.0)
        
        if let layout = self.eventsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
            layout.itemSize = CGSize(width: self.eventsCollectionView.bounds.width * 0.88, height: 316.0)
        }
    }
    
    fileprivate func getPageSelectorCell(_ collectionView: UICollectionView, fotItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageIndicatorCollectionViewCell", for: indexPath) as! PageIndicatorCollectionViewCell
        let model = pageModels[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    fileprivate func getEventCell(_ collectionView: UICollectionView, fotItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let model = eventsModels[indexPath.item]
        cell.configure(with: model)
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
            return self.eventsModels.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
