//
//  GetEventsRequest.swift
//  InSearch
//
//  Created by Gregory Berngardt on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetEventsRequest: BaseServerRequest<[Event]> {
    
    private let category: String
    private struct Keys {
        public static let category = "category"
    }
    
    // MARK: - Initialization and deinitialization
    
    init(category: String) {
        self.category = category
    }
    
    override func createAsyncServerRequest() -> ServerRequest {
        var params = [String: Any]()
        params[Keys.category] = category
        return ServerRequest(method: .get,
                             relativeUrl: URLs.events,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(params))
    }
    
    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<[Event]>) -> Void) {
        let result = {() -> ResponseResult<[Event]> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(let value, let  flag):
                guard let result = (value as? [String: Any])?["result"],
                    let mapped = Mapper<Event>().mapArray(JSONObject: result) else {
                        return .failure(BaseServerError.cantMapping)
                }
                return .success(mapped, flag)
            }
        }()
        completion(result)
    }
    
}
