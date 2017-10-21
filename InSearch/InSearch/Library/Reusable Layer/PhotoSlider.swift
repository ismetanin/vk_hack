//
//  PhotoSlider.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit

final class PhotoSlider: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Static
    
    class func instanceFromNib() -> PhotoSlider {
        let nibName = String(describing: PhotoSlider.self)
        let nib = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first
        return nib as? PhotoSlider ?? PhotoSlider()
    }
    
    // MARK: - Internal helpers
    
    func configure(with urlStrings: [String]) {
        scrollView.delegate = self
        pageControl.numberOfPages = urlStrings.count
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        pageControl.subviews.forEach { $0.addShadow(opacity: 0.2) }
        urlStrings.forEach { string in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.setImage(withUrlString: string, placeholderImage: nil)
            stackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: widthAnchor),
                imageView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        }
    }
}

// MARK: - UIScrollViewDelegate

extension PhotoSlider: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewVerticalPosition = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.size.height
        pageControl.currentPage = Int(scrollViewVerticalPosition/scrollViewHeight)
    }
}
