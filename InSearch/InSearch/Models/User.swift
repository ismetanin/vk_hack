//
//  User.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import ObjectMapper

final class User: Mappable {

    // MARK: - Enums

    enum Gender: String {
        case male = "male"
        case female = "female"
    }

    // MARK: - Properties

    var id: String?
    var name: String?
    var chatId: String?
    var avatarURLStrings: [String]?
    var gender: Gender?
    var city: String?
    var age: Int?

    // MARK: - Initialization and deinitialization

    required convenience init?(map: Map) {
        self.init()
    }

    // MARK: - Mappable

    func mapping(map: Map) {
        name <- map[MappingKeys.name]
        if let genderValue: String = map.JSON[MappingKeys.gender] as? String {
            gender = Gender(rawValue: genderValue)
        }
        avatarURLStrings <- map[MappingKeys.avatarURLString]
        chatId <- map[MappingKeys.chatId]
        city <- map[MappingKeys.city]
    }
}

// MARK: MappingKeys

private extension User {
    class MappingKeys {
        static let name = "name"
        static let secondName = "secondName"
        static let avatarURLString = "avatarURLString"
        static let gender = "gender"
        static let chatId = "chatId"
        static let city = "city"
    }
}
