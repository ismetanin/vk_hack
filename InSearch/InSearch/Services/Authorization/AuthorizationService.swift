//
//  AuthorizationAuthorizationService.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class AuthorizationService {
    func sendToken(token: String, completion: @escaping (BaseResult<Void>) -> Void) {
        let request = SendTokenRequest(accessToken: token)
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
