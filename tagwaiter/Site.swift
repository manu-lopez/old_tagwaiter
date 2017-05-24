//
//  Site.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Foundation
import ObjectMapper

class Site: Mappable{
    
    var id: String?
    var name: String?
    var areCalling, areAskingBill: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        areCalling      <- map["areCalling"]
        areAskingBill   <- map["areAskingBill"]
    }
}
