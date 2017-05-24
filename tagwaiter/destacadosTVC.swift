//
//  destacadosTVC.swift
//  tagwaiter
//
//  Created by Manu on 21/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class destacadosTVC: UIViewController, UITableViewDelegate {

//    let lang = UserDefaults.standard.value(forKey: "lang") as! String
//    let url = "http://api.disainin.com/foodtags/1/shop"
//    let header: HTTPHeaders = [
//        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
//    ]
//    
//    override func viewDidLoad() {
//        getDataFromDB()
//    }
//    
//    func getDataFromDB(){
//        
//        
//        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
//            
//            let shop = response.result.value
//            print(type(of: shop))
//            
//            if let categories = shop?.categories {
//                print(type(of: categories))
//                for a in categories{
//                    print(type(of: a))
//                    let name = a.name
//                    for a in name!{
//                        if a.language == self.lang {
//                            print(a.text)
//                        }
//                    }
//                }
//            }
//        }
//    }
}
