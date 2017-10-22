//
//  GetProfileRequest.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetProfileRequest: BaseServerRequest<User> {
    
    override func createAsyncServerRequest() -> ServerRequest {
        return ServerRequest(method: .get,
                             relativeUrl: URLs.profile,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(nil))
    }
    
    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<User>) -> Void) {
        
        let result = {() -> ResponseResult<User> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(let value, let  flag):
                guard
                    let result = (value as? [String: Any])?["result"] as? [String: Any],
                    let mapped = Mapper<User>().map(JSON: result)
                    else {
                        return .failure(BaseServerError.cantMapping)
                }
                return .success(mapped, flag)
            }
        }()
        completion(result)
    }
    
}
