//
//  Session.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift

class Session: Object{
    
    var dateStart = Double(NSDate().timeIntervalSince1970)
    var dateEnd = 0
    var token = (UserDefaults.standard.value(forKey: "token")! as! String)
    var orders =  List<SessionOrder>()
    
    override static func primaryKey() -> String? {
        return "token"
    }
    
}
