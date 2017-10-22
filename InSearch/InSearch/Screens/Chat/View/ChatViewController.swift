//
//  ChatViewController.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit
import iCarousel
import IQKeyboardManager

final class ChatViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    // MARK: - IBOutlets

    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var carousel: iCarousel!
    @IBOutlet private weak var eventDescriptionView: UIView!

    // MARK: - Constants

    private let numberOfTips = 3
    private let tipCardSidesInset: CGFloat = 40

    // MARK: - Properties

    private var tips: [String] = [
        "Пойдешь на выборы в 20!8?",
        "Кажется, ты в группе Хакатона ВК 2017, едешь туда?",
        "Как тебе последний альбом группы Мальбэк?",
        "Ого, ты слушаешь Хлеб? Что ты думаешь об их творчестве?",
        "Должно быть, это больно… падать с небес.",
        "Время не подскажете?.. А свободного?",
        "А что ты делаешь всю оставшуюся жизнь?",
        "Привет, как погодка?",
        "Не правда ли уныло и скучно на душе, может прогуляемся?",
        "Ой! А кто это такой красивый такой тут у нас?",
        "Привет, да ты милашка!",
        "Я так нервничаю. Можно я тебе куплю что-нибудь выпить?",
        "Вдарим по шавухе?"
    ]

    private var eventTips: [String] = [
        "Я думаю, это прекрасное событие, сходим вместе?",
        "Как насчет провести завтрашний вечер вот тут?",
        "Как насчет заглянуть сюда завтра?"
    ]
    
    public var user: User?
    public var event: Event?

    // MARK: - IBActions

    @IBAction func sendButtonAction(_ sender: UIButton) {
        if let userId = user?.id {
            ChatService().sendMessage(userId: user?.id, message: messageTextView.text, eventId: event?.id, completion: { (result) in
                self.navigationController?.popToRootViewController(animated: true)
            })
        }

    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // make random sorted array of tips
//        tips = tips.shuffled
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureTitle()
        IQKeyboardManager.shared().isEnabled = true
        if let event = event,
            let eventView = Bundle.main.loadNibNamed("EventDetailsHeaderTableViewCell", owner: self, options: nil)?.first as? EventDetailsHeaderTableViewCell {

            eventView.frame = eventDescriptionView.frame
            let model = EventDetailsHeaderTableViewCell.Model(with: event)
            eventView.configure(with: model, isNeedHideActionButton: true)
            self.eventDescriptionView.addSubview(eventView)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }

    // MARK: - Private helpers

    private func setupViews() {
        carousel.type = .linear
        carousel.bounceDistance = 0.2
        carousel.delegate = self
        carousel.dataSource = self

        messageTextView.layer.cornerRadius = 12
        messageTextView.layer.borderColor = UIColor.gray.cgColor
        messageTextView.layer.borderWidth = 1


    }
    
    /// Настраивает заголовок экрана
    /// Если есть пользователь, то его имя будет являться заголовком
    private func configureTitle() {
        if let userName = self.user?.name {
            self.title = userName
        }
    }

    // MARK: - iCarousel

    func numberOfItems(in carousel: iCarousel) -> Int {
        return tips.count > 3 ? 3 : tips.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let itemView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 63))
        itemView.backgroundColor = .clear

        if let tipView = Bundle.main.loadNibNamed("TipView", owner: self, options: nil)?.first as? TipView {
            // Configure tip view
            tipView.frame = CGRect(x: 25, y: 0, width: self.view.frame.width - 50, height: 63)
            tipView.backgroundColor = .white
            tipView.layer.borderWidth = 1
            tipView.layer.borderColor = UIColor.Gray.main.cgColor
            tipView.layer.cornerRadius = tipView.frame.height / 3
            if event != nil {
                tipView.fill(with: eventTips[index])
            } else {
                tipView.fill(with: tips[index])
            }
            itemView.addSubview(tipView)
        }
        return itemView
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if event != nil {
            messageTextView.text = eventTips[index]
        } else {
            messageTextView.text = tips[index]
        }
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.9
        }
        return value
    }
}

