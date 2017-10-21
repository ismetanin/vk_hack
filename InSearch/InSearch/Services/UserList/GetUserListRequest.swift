//
//  GetUserListRequest.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetUserListRequest: BaseServerRequest<[User]> {

    override func createAsyncServerRequest() -> ServerRequest {
        return ServerRequest(method: .get,
                             relativeUrl: URLs.base,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(nil))
    }

    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<[User]>) -> Void) {
        completion(ResponseResult<[User]>.success([User(), User()], false))

//        let result = {() -> ResponseResult<[User]> in
//            switch serverResponse.result {
//            case .failure(let error):
//                return .failure(error)
//            case .success(let value, let  flag):
//                guard let mapped = Mapper<User>().mapArray(JSONObject: value) else {
//                    return .failure(BaseServerError.cantMapping)
//                }
//                return .success(mapped, flag)
//            }
//        }()
//        completion(result)
    }
    
}
