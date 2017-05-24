//
//  Category.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import Foundation
import ObjectMapper

class Category: Mappable{
    
    var id: Int?
    var name: Array<Translation>?
    var imagePathName: String?
    var sizes: Array<CategorySize>?
    var types: Array<CategoryType>?
    var items: Array<Item>?
    var isEnabled: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id            <- map["_id"]
        imagePathName <- map["imagePathName"]
        name          <- map["name"]
        sizes         <- map["sizes"]
        types         <- map["types"]
        isEnabled     <- map["isEnabled"]
        items         <- map["items"]

    }
}

