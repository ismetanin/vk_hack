//
//  EventsService.swift
//  InSearch
//
//  Created by Gregory Berngardt on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class EventsService {
    
    class func getEventsList(category: Category, completion: @escaping (BaseResult<[Event]>) -> Void) {
        let request = GetEventsRequest(category: category.id ?? "")
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
