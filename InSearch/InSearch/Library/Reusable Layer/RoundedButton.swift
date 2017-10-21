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
    
    override var isHighlighted: Bool{
        didSet {
            if isHighlighted {
                self.alpha = 0.8
            } else {
                self.alpha = 1.0
            }
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

    
    
}
