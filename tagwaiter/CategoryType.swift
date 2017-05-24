//
//  CategoryType.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Foundation
import ObjectMapper

class CategoryType: Mappable{
    
    var id: Int?
    var name: Array<Translation>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["_id"]
        name    <- map["name"]
    }
}
