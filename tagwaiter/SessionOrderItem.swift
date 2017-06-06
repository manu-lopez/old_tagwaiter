//
//  SessionOrderItem.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class SessionOrderItem: Object, Mappable{
    
    dynamic var categoryId = 0
    dynamic var itemId = 0
    dynamic var observations = ""
    var sizes = List<SessionOrderItemSize>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON{
        categoryId <- map["categoryId"]
        itemId <- map["itemId"]
        observations <- map["observations"]
        sizes <- map["sizes"]
        } else {
            categoryId >>> map["categoryId"]
            itemId >>> map["itemId"]
            observations >>> map["observations"]
            sizes >>> (map["sizes"], ListTransform<SessionOrderItemSize>())
        }
    }
}
