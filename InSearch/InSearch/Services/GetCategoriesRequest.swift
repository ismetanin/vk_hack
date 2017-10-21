//
//  GetCategoriesRequest.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetCategoriesRequest: BaseServerRequest<[Category]> {

    override func createAsyncServerRequest() -> ServerRequest {
        return ServerRequest(method: .get,
                             relativeUrl: URLs.categories,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(nil))
    }

    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<[Category]>) -> Void) {
        let result = {() -> ResponseResult<[Category]> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(let value, let  flag):
                guard let result = (value as? [String: Any])?["result"],
                      let mapped = Mapper<Category>().mapArray(JSONObject: result) else {
                    return .failure(BaseServerError.cantMapping)
                }
                return .success(mapped, flag)
            }
        }()
        completion(result)
    }

}
