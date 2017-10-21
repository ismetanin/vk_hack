//
//  UserService.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

final class UserService {
    class func getUsers(completion: @escaping (BaseResult<[User]>) -> Void) {
        let request = GetUsersRequest()
        request.performAsync { (result) in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let value, let flag):
                completion(.value(value, flag))
            }
        }
    }

    class func getUser(completion: @escaping (BaseResult<[User]>) -> Void) {
        
    }
    
    class func postLikes(id: String, completion: @escaping (BaseResult<Void>) -> Void) {
        let request = PostLikesRequest(id: id)
        request.performAsync { (result) in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(_, let flag):
                completion(.value((), flag))
            }
        }
    }
    
    class func postDislikes(id: String, completion: @escaping (BaseResult<Void>) -> Void) {
        let request = PostDislikesRequest(id: id)
        request.performAsync { (result) in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(_, let flag):
                completion(.value((), flag))
            }
        }
    }
}
