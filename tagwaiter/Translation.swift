//
//  Translation.swift
//  tagwaiter
//
//  Created by Manu on 23/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Foundation
import ObjectMapper

class Translation: Mappable{
    
    var language: String?
    var text: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        language    <- map["language"]
        text        <- map["text"]
    }
}
