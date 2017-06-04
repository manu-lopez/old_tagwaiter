//
//  SessionOrder.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift

class SessionOrder: Object{
    
    var sesionID = (UserDefaults.standard.value(forKey: "token")! as! String)
    var date = Int(NSDate().timeIntervalSince1970)
    var visible = true
    var items = List<SessionOrderItem>()
    
    override static func primaryKey() -> String? {
        return "sesionID"
    }
}
