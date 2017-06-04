//
//  SessionOrderItem.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import RealmSwift

class SessionOrderItem: Object{
    
    var categoryId = 0
    var itemId = 0
    var observations: String?
    var sizes = List<SessionOrderItemSize>()
    
}
