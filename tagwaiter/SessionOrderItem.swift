//
//  SessionOrderItem.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Foundation
import ObjectMapper

class SessionOrderItem: Mappable{
    
    var categoryId, itemId: Int?
    var observations: String?
    var sizes: Array<SessionOrderItemSize>?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        categoryId      <- map["categoryId"]
        itemId          <- map["itemId"]
        observations    <- map["observations"]
        sizes           <- map["sizes"]
    }
}
