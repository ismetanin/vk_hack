//
//  PostDislikesRequest.swift
//  InSearch
//
//  Created by Anton Dryakhlykh on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class PostDislikesRequest: BaseServerRequest<Void> {
    
    // MARK: - Constants
    
    private let id: String
    
    // MARK: - Initialization and deinitialization
    
    init(id: String) {
        self.id = id
    }
    
    // MARK: - BaseServerRequest
    
    override func createAsyncServerRequest() -> ServerRequest {
        var params = [String: Any]()
        params["user_id"] = id
        return ServerRequest(method: .post,
                             relativeUrl: URLs.dislikes,
                             baseUrl: URLs.base,
                             token: token,
                             parameters: .simpleParams(params))
    }
    
    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<Void>) -> Void) {
        let result = {() -> ResponseResult<Void> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(_, let  flag):
                return .success((), flag)
            }
        }()
        completion(result)
    }
    
}
