//
//  CategoriesService.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class CategoriesService {

    class func getCategoryList(completion: @escaping (BaseResult<[Category]>) -> Void) {
        let request = GetCategoriesRequest()
        request.performAsync { (result) in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let value, let flag):
                completion(.value(value, flag))
            }
        }
    }

    class func sendCategories(ids: [String], completion: @escaping (BaseResult<Void>) -> Void) {
        let request = SendCategoriesRequest(ids: ids)
        request.performAsync { (result) in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let value, let flag):
                completion(.value(value, flag))
            }
        }
    }

}
