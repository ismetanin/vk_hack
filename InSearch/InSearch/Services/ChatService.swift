//
//  ChatService.swift
//  InSearch
//
//  Created by Ivan Smetanin on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class ChatService {
    func sendMessage(userId: String, message: String, eventId: String?, completion: @escaping (BaseResult<Void>) -> Void) {
        let request = SendMessageRequest(userId: userId, message: message, eventId: eventId)
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
