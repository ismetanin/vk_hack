//
//  GetReactionsRequest.swift
//  InSearch
//
//  Created by Gregory Berngardt on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetReactionsRequest: BaseServerRequest<[Reaction]> {
    
    override func createAsyncServerRequest() -> ServerRequest {
        return ServerRequest(method: .get,
                             relativeUrl: URLs.reactions,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(nil))
    }
    
    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<[Reaction]>) -> Void) {
        let result = {() -> ResponseResult<[Reaction]> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(let value, let  flag):
                guard let result = (value as? [String: Any])?["result"],
                    let mapped = Mapper<Reaction>().mapArray(JSONObject: result) else {
                        return .failure(BaseServerError.cantMapping)
                }
                return .success(mapped, flag)
            }
        }()
        completion(result)
    }
    
}
