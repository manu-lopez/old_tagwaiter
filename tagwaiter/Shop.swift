//
//  Shop.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class Shop: Mappable{
    
    var name: String?
    var categories: Array<Category>?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        name        <- map["name"]
        categories  <- map["categories"]
    }
}
