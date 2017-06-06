//
//  Session.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift
import ObjectMapper

class Session: Object, Mappable{
    
    dynamic var dateStart = Double(NSDate().timeIntervalSince1970)
    dynamic var dateEnd = 0
    dynamic var token = (UserDefaults.standard.value(forKey: "token")! as! String)
    var orders =  List<SessionOrder>()
    
    override static func primaryKey() -> String? {
        return "token"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dateStart <- map["dateStart"]
        dateEnd <- map["dateEnd"]
        token <- map["token"]
        orders <- map["orders"]
    }
    
}
