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
    var categorieName = ""
    var categories = [Category]()
    var nameItems = [String]()
    var numItems = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categorieName
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.categories = (shop?.categories)!
            
            for categorie in self.categories{
                if categorie.id == self.categorieID{
                    self.numItems = (categorie.items?.count)!
                    for items in categorie.items!{
                        self.nameItems.append(items.name!)
                    }
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ItemMenu", owner: self, options: nil)?.first as! ItemMenu
        
        cell.ProductName.text = nameItems[indexPath.row]
        
        return cell
    }
    
}
