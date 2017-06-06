//
//  SessionOrderItemSize.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift
import ObjectMapper

class SessionOrderItemSize: Object, Mappable{
    
    dynamic var sizeId = 0
    dynamic var quantity = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON{
            sizeId <- map["sizeId"]
            quantity <- map["quantity"]
        } else {
            quantity >>> map["quantity"]
            sizeId >>> map["sizeId"]
        }
    }
}
