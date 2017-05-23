//
//  Menu.swift
//  tagwaiter
//
//  Created by Manu on 22/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import ObjectMapper

class Menu: Mappable{
    var id: Int?
    var name: Array<String>?
    var imagePathName: String?
    var sizes: Array<AnyObject>?
    var types: [Type]?
    var items: [Item]?
    var isEnabled: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map){
        id            <- map["_id"]
        imagePathName <- map["imagePathName"]
        name          <- map["name"]
        sizes         <- map["sizes"]
        types         <- map["types"]
        isEnabled     <- map["isEnabled"]
        items         <- map["items"]
    }
    
}

class Type: Mappable{
    var id: Int?
    var name: Array<String>?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id   <- map["_id"]
        name <- map["name"]
    }
}

class Items: Mappable{
    var id: Int?
    var isEnabled: Bool?
    var isPromo: Bool?
    var name: String?
    var imagePathName: String?
    var description: String?
    var type: Int?
    var price: Array<AnyObject>?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id            <- map["_id"]
        isEnabled     <- map["isEnabled"]
        isPromo       <- map["isPromo"]
        name          <- map["name"]
        imagePathName <- map["imagePathName"]
        description   <- map["description"]
        type          <- map["type"]
        price         <- map["prices"]
        
    }
    
}

