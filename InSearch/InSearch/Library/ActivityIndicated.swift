//
//  ActivityIndicated.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

struct IndicatorItem {
    let style: UIActivityIndicatorViewStyle = .whiteLarge

    fileprivate weak var view: UIView?
    private weak var color: UIColor?

    private(set) weak var indicator: UIActivityIndicatorView? {
        willSet {
            indicator?.removeFromSuperview()
        }
        didSet {
            if let activityIndicator = indicator, let view = self.view {
                activityIndicator.center = view.center
                activityIndicator.color = color ?? .white
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            }
        }
    }

    init(view: UIView, color: UIColor? = nil) {
        self.view = view
        self.color = color
    }

    mutating func make(visible: Bool) {
        indicator = visible ? UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge) : nil
        view?.isUserInteractionEnabled = !visible
    }
}

// TODO: Create IndicatorItemProtocol for use different indicators
protocol ActivityIndicated {
    var indicator: IndicatorItem? { get set }
}
