//
//  MenuTVC.swift
//  tagwaiter
//
//  Created by Manu on 24/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import Alamofire

class MenuTVC: UIViewController, UITableViewDelegate {
        
    let lang = UserDefaults.standard.value(forKey: "lang") as! String
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    var numCategories = 0
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.numCategories = (shop?.categories?.count)!
            self.categories = (shop?.categories)!
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return numCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        for i in categories{
            if i.name?[indexPath.row].text == self.lang {
                cell.textLabel?.text = i.name?[indexPath.row].text
            }
        }
     return cell
    }
}
