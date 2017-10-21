//
//  RoundedButton.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: - Properties
    
    var borderColor: UIColor = UIColor.black
    var borderWidth: CGFloat = 0.0
    
    private var customBackgroundColor = UIColor.white
    
    // MARK: - UIButton

    override var backgroundColor: UIColor?{
        didSet {
            customBackgroundColor = backgroundColor!
            super.backgroundColor = UIColor.clear
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = rect.height / 2.0
        customBackgroundColor.setFill()
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ).fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        growAnimated()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        shrinkAnimated()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        super.backgroundColor = UIColor.clear
    }
    
    // MARK: - Private
    
    private func growAnimated() {
        UIView.animate(withDuration: 0.1) { () -> Void in
            let shrinkTransform = CGAffineTransform.identity.scaledBy(x: 1.03, y: 1.03)
            self.transform = shrinkTransform
        }
    }
    
    private func shrinkAnimated() {
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.transform = CGAffineTransform.identity
        }
    }

    
    
}
