//
//  SessionOrder.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class SessionOrder: Object, Mappable{
    
    dynamic var token = (UserDefaults.standard.value(forKey: "token")! as! String)
    dynamic var date = Int(NSDate().timeIntervalSince1970)
    dynamic var visible = true
    var items = List<SessionOrderItem>()
    
    override static func primaryKey() -> String? {
        return "token"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON{
            date <- map["date"]
            visible <- map["isVisible"]
            items <- map["items"]
        } else {
            items >>> (map["items"], ListTransform<SessionOrderItem>())
            date >>> map["date"]
            visible >>> map["isVisible"]
        }
    }
}
