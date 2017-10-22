//
//  ProfileService.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class ProfileService {
    class func getProfile(completion: @escaping (BaseResult<User>) -> Void) {
        let request = GetProfileRequest()
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
