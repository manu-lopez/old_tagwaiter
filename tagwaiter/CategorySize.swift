//
//  CategorySize.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class CategorySize: Mappable{
    
    var id: Int?
    var dimension: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        id          <- map["_id"]
        dimension   <- map["dimension"]
    }
}
