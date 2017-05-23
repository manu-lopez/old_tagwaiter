//
//  Session.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class Session: Mappable{
    
    var dateStart, dateEnd: Double?
    var token: String?
    var orders: Array<SessionOrder>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateStart   <- map["dateStart"]
        dateEnd     <- map["dateEnd"]
        token       <- map["token"]
        orders      <- map["orders"]
    }
}
