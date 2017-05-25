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
    var paths = [String]()
    
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categorieName
        
        showIndicator()
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.categories = (shop?.categories)!
            
            for categorie in self.categories{
                if categorie.id == self.categorieID{
                    self.numItems = (categorie.items?.count)!
                    for items in categorie.items!{
                        self.nameItems.append(items.name!)
                        self.paths.append("http://media.disainin.com/tagwaiter/images/w500h500/\(items.imagePathName!)")
                    }
                    self.indicator.stopAnimating()
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemMenu", for: indexPath) as! ItemMenu
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.sd_setImage(with: URL(string: paths[indexPath.row]))
        
        cell.ProductName.text = nameItems[indexPath.row]
        
        return cell
    }
    
    //mostramos indicador de carga
    func showIndicator(){
        
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicator)
        
        indicator.startAnimating()
    }
    
}
