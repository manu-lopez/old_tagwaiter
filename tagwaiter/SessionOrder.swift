//
//  SessionOrder.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift

class SessionOrder: Object{
    
    var date: Double?
    var visible: Bool?
    var items = List<SessionOrderItem>()
    
}
