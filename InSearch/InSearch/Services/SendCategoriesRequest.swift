//
//  SendCategoriesRequest.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class SendCategoriesRequest: BaseServerRequest<Void> {

    // MARK: - Constants

    private let ids: [String]

    // MARK: - Initialization and deinitialization

    init(ids: [String]) {
        self.ids = ids
    }

    // MARK: - BaseServerRequest

    override func createAsyncServerRequest() -> ServerRequest {
        var params = [String: Any]()
        params["ids"] = ids
        return ServerRequest(method: .post,
                             relativeUrl: URLs.categories,
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
