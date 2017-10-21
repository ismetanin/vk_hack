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

import UIKit

extension Array {

    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }

    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }

    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            swap(&self[$0], &self[index])
        }
        return self
    }


    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}

final class ChatViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    // MARK: - IBOutlets

    @IBOutlet private
    weak var messageTextView: UITextView!
    @IBOutlet private weak var carousel: iCarousel!

    // MARK: - Constants

    private let numberOfTips = 3
    private let tipCardSidesInset: CGFloat = 40

    // MARK: - Properties

    private var tips: [String] = [
        "Как тебе последний альбом группы Мальбэк?",
        "Пойдешь на выборы 20!8?",
        "Кажется, ты в группе Хакатона ВК 2017, едешь туда?",
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
        "Как насчет провести завтрашний вот тут?"
    ]

    // MARK: - IBActions

    @IBAction func sendButtonAction(_ sender: UIButton) {
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
        IQKeyboardManager.shared().isEnabled = true
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
            tipView.fill(with: tips[index])
            itemView.addSubview(tipView)
        }
        return itemView
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        messageTextView.text = tips[index]
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.9
        }
        return value
    }
}

