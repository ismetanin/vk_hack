//
//  Reaction.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import ObjectMapper

final class Reaction: Mappable {

    // MARK: - Properties

    var user: User?
    var timestamp: Date?
    var mutually: Bool = false

    // MARK: - Initialization and deinitialization

    required convenience init?(map: Map) {
        self.init()
    }

    // MARK: - Mappable

    func mapping(map: Map) {
        user <- map[MappingKeys.user]
        timestamp <- (map[MappingKeys.timestamp], ISO8601DateTransform())
        mutually <- map[MappingKeys.mutually]
    }
}

// MARK: MappingKeys

private extension Reaction {
    class MappingKeys {
        static let user = "user"
        static let timestamp = "timestamp"
        static let mutually = "mutually"
    }
}
