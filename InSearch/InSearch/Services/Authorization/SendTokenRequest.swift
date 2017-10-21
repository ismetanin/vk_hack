//
//  SendTokenRequest.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class SendTokenRequest: BaseServerRequest<Void> {

    // MARK: - Constants

    private let accessToken: String
    private struct Keys {
        public static let token = "token"
    }

    // MARK: - Initialization and deinitialization

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    // MARK: - BaseServerRequest

    override func createAsyncServerRequest() -> ServerRequest {
        var params = [String: Any]()
        params[Keys.token] = accessToken
        return ServerRequest(method: .post,
                             relativeUrl: URLs.auth,
                             baseUrl: URLs.base,
                             parameters: .simpleParams(params))
    }

    override func handle(serverResponse: ServerResponse, completion: (ResponseResult<Void>) -> Void) {
        let result = {() -> ResponseResult<Void> in
            switch serverResponse.result {
            case .failure(let error):
                return .failure(error)
            case .success(let value, let  flag):
                debugPrint(value)
                guard let mapped = (value as? [String: Any])?[Keys.token] else {
                    return .failure(BaseServerError.cantMapping)
                }
                do {
                    try KeychainStorage().save(
                        data: [Constants.Keys.accessToken : mapped],
                        forUserAccount: Constants.Keys.userAccount
                    )
                } catch {
                    return .failure(BaseServerError.undefind)
                }
                return .success((), flag)
            }
        }()
        completion(result)
    }
    
}
