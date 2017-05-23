//
//  Item.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class Item: Mappable{
    
    var id: Int?
    var isEnabled, isPromo: Bool?
    var name, imagePathName: String?
    var description: Array<Translation>?
    var type: Int?
    var price: Array<ItemPrice>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["_id"]
        isEnabled       <- map["isEnabled"]
        isPromo         <- map["isPromo"]
        name            <- map["name"]
        imagePathName   <- map["imagePathName"]
        description     <- map["description"]
        type            <- map["type"]
        price           <- map["prices"]

    }
}
