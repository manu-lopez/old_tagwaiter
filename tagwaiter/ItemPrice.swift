//
//  ItemPrice.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class ItemPrice: Mappable{
    
    var sizeId: Int?
    var price: Float?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sizeId  <- map["sizeId"]
        price   <- map["price"]
    }
}
