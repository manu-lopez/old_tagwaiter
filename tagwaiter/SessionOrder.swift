//
//  SessionOrder.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class SessionOrder: Mappable{
    
    var date: Double?
    var visible: Bool?
    var items: Array<SessionOrderItem>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date        <- map["date"]
        visible     <- map["visible"]
        items       <- map["items"]
    }
}
