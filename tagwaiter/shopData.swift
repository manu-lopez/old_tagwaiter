////
////  shopData.swift
////  tagwaiter
////
////  Created by Manu on 22/5/17.
////  Copyright © 2017 Manu. All rights reserved.
////
//
//import Alamofire
//import AlamofireObjectMapper
//
//class data {
//    
//    let url = "http://api.disainin.com/foodtags/1/shop"
//    let headers: HTTPHeaders = [
//        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
//    ]
//    
//    func getDataFromDB() {
//        Alamofire.request(url, headers: headers).responseObject { (response: DataResponse<Menu>) in
//            
//            let menuResponse = response.result.value
//            print(menuResponse?.nameshop)
//            
//            if let categories = menuResponse?.categories{
//                for item in categories{
//                    print("ID -> \(item.id)")
//                    print("name -> \(item.name)")
//                    print("count sizes -> \(item.sizes?.count)")
//                }
//            }
//        }
//        
//    }
//}
