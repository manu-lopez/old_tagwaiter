//
//  MenuVC.swift
//  tagwaiter
//
//  Created by Manu on 24/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class MenuCategorieVC: UITableViewController {
    
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    var categorieID = 0
    var categories = [Category]()
    var numCategories = 0
    var categorieName = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(categorieID)
        
//        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
//            
//            let shop = response.result.value
//            self.categories = (shop?.categories)!
//            self.numCategories = (shop?.categories?.count)!
//            
//            for categorie in self.categories{
//                for data in categorie.name!{
//                    if data.language == UserDefaults.standard.value(forKey: "lang") as? String{
//                        self.categorieName.append(data.text!)
//                    }
//                }
//            }
//            
//            self.tableView.reloadData()
//        }
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numCategories
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        
//        cell.textLabel?.text = categorieName[indexPath.row]
//        
//        return cell
//    }
    
}
