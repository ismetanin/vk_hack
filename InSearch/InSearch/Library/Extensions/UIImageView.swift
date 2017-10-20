//
//  UIImageView.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {

    func setImage(withUrlString urlString: String?, placeholderImage: UIImage?, completion: (() -> Void)? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholderImage
            completion?()
            return
        }
        setImage(with: url, placeholder: placeholderImage, completion: { _ in
            completion?()
        })
    }

    func setImage(with url: URL, placeholder: UIImage?, completion: ((Alamofire.DataResponse<UIImage>) -> Void)? = nil) {
        self.af_setImage(
            withURL: url,
            placeholderImage: placeholder,
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.global(qos: DispatchQoS.QoSClass.background),
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: completion
        )
    }
    
}
