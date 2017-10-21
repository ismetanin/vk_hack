//
//  Category.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import ObjectMapper

final class Category: Mappable {

    // MARK: - Properties

    var id: String?
    var title: String?
    var type: String?
    var normalImage: UIImage? {
        guard let iconName = type else {
            return nil
        }
        return UIImage(named: "icon_" + iconName)
    }
    var selectedImage: UIImage? {
        guard let iconName = type else {
            return nil
        }
        return UIImage(named: "icon_" + iconName + "_selected")
    }

    // MARK: - Initialization and deinitialization

    required convenience init?(map: Map) {
        self.init()
    }

    // MARK: - Mappable

    func mapping(map: Map) {
        id <- map[MappingKeys.id]
        title <- map[MappingKeys.title]
        type <- map[MappingKeys.type]
    }
}

// MARK: MappingKeys

private extension Category {
    class MappingKeys {
        static let id = "id"
        static let title = "title"
        static let type = "type"
        static let iconName = "iconName"
    }
}
