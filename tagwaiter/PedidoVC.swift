//
//  PedidoVC.swift
//  tagwaiter
//
//  Created by Manu on 5/6/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class PedidoVC: UITableViewController {
    
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    let realm = try! Realm()
    let token = (UserDefaults.standard.value(forKey: "token")! as! String)
    var sesionorder: SessionOrder!
    var categories = [Category]()
    var nameShow = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameShow = []
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            self.sesionorder = self.realm.object(ofType: SessionOrder.self, forPrimaryKey: self.token)!
            let shop = response.result.value
            self.categories = (shop?.categories)!
            
            for category in self.categories{
                for itemO in self.sesionorder.items{
                    if category.id == itemO.categoryId{
                        for item in category.items!{
                            if item.id == itemO.itemId{
                                for sizeid in itemO.sizes{
                                    for sizename in category.sizes!{
                                        if sizeid.sizeId == sizename.id{
                                            if sizename.dimension == nil{
                                                self.nameShow.append("\(item.name!) - estandar x \(sizeid.quantity)")
                                            } else {
                                                self.nameShow.append("\(item.name!) - \(sizename.dimension!) x \(sizeid.quantity)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //Actualizamos la tabla para que se muestren los campos
            self.tableView.reloadData()
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.nameShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.nameShow[indexPath.row]
        return cell
    }
    
    @IBAction func callWaiter(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func makeOrder(_ sender: UIBarButtonItem) {
        let json = Mapper().toJSONString(self.sesionorder)
        
        var validjson = json?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        Alamofire.request("http://api.disainin.com/foodtags/1/session/orders/add/\(validjson!)",headers: header).responseJSON { response in
            if let resultado = response.result.value {
                print("EXITO")
                //probar a crear todos los objetos vacios y actualizar session order con los vacios para poder añadir neuvas
            }
        }
    }
    
}
