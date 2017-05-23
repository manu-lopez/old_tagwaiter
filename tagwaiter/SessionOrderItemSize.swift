//
//  SessionOrderItemSize.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class SessionOrderItemSize: Mappable{
    
    var sizeId, quantity: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sizeId      <- map["sizeId"]
        quantity    <- map["quantity"]
    }
}
