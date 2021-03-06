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
    fileprivate var selectedPageIndex: Int = 0
    fileprivate var indicator: IndicatorItem?


    fileprivate var events: [Event] = [] {
        didSet {
            self.eventsModels = events.map({EventCollectionViewCell.Model(with: $0)})
            self.eventsCollectionView.reloadData()
        }
    }
    fileprivate var categories: [Category] = [] {
        didSet {
            self.pageModels = categories.map({PageModel(with: $0)})
            self.pageSelectorCollectionView.reloadData()
            self.selectPage(at: 0)
        }
    }
    fileprivate var selectedCategory: Category {
        return self.categories[selectedPageIndex]
    }
    
    fileprivate var bufferedBarTintColor: UIColor?

    public var user: User?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = IndicatorItem(view: self.view, color: UIColor.Red.main)
        
        self.configureNavigationBarStyle()
        self.configureTitle()
      
        self.configurePageSelectorCollectionView()
        self.configureEventsCollectionView()
        
        loadCategoriesAndSetupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureTitle()
        self.configureNavigationBarStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = nil
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.revertNavigationBarStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updatePageSelectorCollectionViewLayout()
        self.updateEventsCollectionViewLayout()
    }
    
    // MARK: - User Actions
    
    fileprivate func inviteActionPerformed(event: Event) {
        self.openChatScreen(event: event)
    }
    
    fileprivate func openEventDetailsActionPerformed(eventModel: EventCollectionViewCell.Model, with index: Int) {
        
        let event = self.events[index]
        
        let eventDetailsViewController = EventDetailsViewController()
        eventDetailsViewController.event = event
        eventDetailsViewController.user = self.user
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
    fileprivate func selectPageActionPerformed(pageModel: PageModel, with index: Int) {
        // TODO: Implement me
        
        self.selectPage(at: index)
    }
    
    // MARK: - Private
    
    /// Настраивает заголовок экрана
    /// Если есть, пользователь, то его имя будет являться заголовком
    private func configureTitle() {
        if let userName = self.user?.name {
            self.title = userName
        } else {
            self.title = L10n.Events.title
        }
    }
    
    private func loadEventsAndSetupView() {
        indicator?.make(visible: true)
        EventsService.getEventsList(category: self.selectedCategory) { [weak self] (result) in
            self?.indicator?.make(visible: false)
            if let events = result.value?.value {
                self?.events = events
            } else {
                // TODO: show error
            }
        }
    }
    
    private func loadCategoriesAndSetupView() {
        CategoriesService.getCategoryList { [weak self] (result) in
            if let categories = result.value?.value {
                self?.categories = categories
            } else {
                // TODO: show error
            }
        }
    }
    
    private func openChatScreen(event: Event) {
        let chatViewController = ChatViewController()
        chatViewController.user = self.user
        chatViewController.event = event
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    fileprivate func eventModel(byIndexPath indexPath: IndexPath) -> EventCollectionViewCell.Model {
        return self.eventsModels[indexPath.item]
    }
    
    private func selectPage(at index: Int) {
        self.eventsCollectionView.deselectItem(at: IndexPath(item: self.selectedPageIndex, section: 0), animated: true)
        self.selectedPageIndex = index
        
        self.loadEventsAndSetupView()
        self.pageSelectorCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func configureNavigationBarStyle() {
        // Удаляем фон
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Изменяем цвет
        self.bufferedBarTintColor = self.navigationController?.navigationBar.tintColor
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func revertNavigationBarStyle() {
        self.navigationController?.navigationBar.tintColor = self.bufferedBarTintColor
    }
    
    private func configurePageSelectorCollectionView() {
    
        self.pageSelectorCollectionView.backgroundColor = .clear
        self.pageSelectorCollectionView.delegate = self
        self.pageSelectorCollectionView.dataSource = self
        self.pageSelectorCollectionView.register(UINib(nibName:"PageIndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageIndicatorCollectionViewCell")
        self.pageSelectorCollectionView.showsVerticalScrollIndicator = false
        self.pageSelectorCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func updatePageSelectorCollectionViewLayout() {
        if let layout = self.pageSelectorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
            layout.itemSize = CGSize(width: 75.0, height: 55.0)
        }
    }
    
    private func configureEventsCollectionView() {
        
        self.eventsCollectionView.backgroundColor = .clear
        self.eventsCollectionView.delegate = self
        self.eventsCollectionView.dataSource = self
        self.eventsCollectionView.register(UINib(nibName:"EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.eventsCollectionView.showsVerticalScrollIndicator = true
        self.eventsCollectionView.showsHorizontalScrollIndicator = false

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
        
        if indexPath.item == self.selectedPageIndex {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    fileprivate func getEventCell(_ collectionView: UICollectionView, fotItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let model = eventsModels[indexPath.item]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    fileprivate func didSelectEvent(with indexPath: IndexPath) {
        let model = self.eventModel(byIndexPath: indexPath)
        self.openEventDetailsActionPerformed(eventModel: model, with: indexPath.item)
    }
    
    fileprivate func didSelectPage(with indexPath: IndexPath) {
        let model = self.pageModels[indexPath.item]
        self.selectPageActionPerformed(pageModel: model, with: indexPath.item)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.pageSelectorCollectionView {
            self.didSelectPage(with: indexPath)
        } else if collectionView == self.eventsCollectionView {
            self.didSelectEvent(with: indexPath)
        }
    }
}

extension EventsViewController: EventCollectionCellDelegate {
    
    func eventCollectionCellDidPressedActionButton(_ eventCell: EventCollectionViewCell) {
        if let indexPath = self.eventsCollectionView.indexPath(for: eventCell) {
            let event = events[indexPath.row]
            self.inviteActionPerformed(event: event)
        }
    }
    
}
