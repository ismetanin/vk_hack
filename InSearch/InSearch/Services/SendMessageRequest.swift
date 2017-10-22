//
//  SendMessageRequest.swift
//  InSearch
//
//  Created by Ivan Smetanin on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation
import ObjectMapper

final class SendMessageRequest: BaseServerRequest<Void> {

    // MARK: - Constants

    private let userId: String
    private let message: String
    private let eventId: String?

    // MARK: - Initialization and deinitialization

    init(userId: String, message: String, eventId: String?) {
        self.userId = userId
        self.message = message
        self.eventId = eventId
    }

    // MARK: - BaseServerRequest

    override func createAsyncServerRequest() -> ServerRequest {
        var params = [String: Any]()
        params["recipient_id"] = userId
        params["message"] = message
        params["event_id"] = eventId

        return ServerRequest(method: .post,
                             relativeUrl: "chat",
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
