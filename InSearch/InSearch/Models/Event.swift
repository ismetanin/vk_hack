//
//  Event.swift
//  InSearch
//
//  Created by Gregory Berngardt on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import ObjectMapper

final class Event: Mappable {
    
    struct Field: Mappable {
        var name: String?
        var value: String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            name <- map["name"]
            value <- map["value"]
        }
    }
    
    // MARK: - Properties
    
    var id: String?
    var title: String?
    var type: String?
    var image: String?
    var category: Category?
    var score: Float?
    var summary: String?
    var fields: [Event.Field]?
    
    // MARK: - Initialization and deinitialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // MARK: - Mappable
    
    func mapping(map: Map) {
        id <- map[MappingKeys.id]
        title <- map[MappingKeys.title]
        type <- map[MappingKeys.type]
        image <- map[MappingKeys.image]
        category <- map[MappingKeys.category]
        score <- map[MappingKeys.score]
        summary <- map[MappingKeys.summary]
        fields <- map[MappingKeys.fields]
    }
    
}

// MARK: MappingKeys

private extension Event {
    class MappingKeys {
        static let id = "id"
        static let title = "title"
        static let type = "type"
        static let image = "image"
        static let category = "category"
        static let score = "score"
        static let summary = "summary"
        static let fields = "fields"
    }
}
