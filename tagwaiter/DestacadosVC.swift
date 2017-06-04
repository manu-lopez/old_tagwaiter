//
//  DestacadosVC.swift
//  tagwaiter
//
//  Created by Manu on 28/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class DestacadosVC: UITableViewController {
    
    //Cabezera y URL
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
                "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    var promoItems = [Item]()
    var indicator = UIActivityIndicatorView()
    
    var sizes = [Int:String]()
    var item: Item!
    var categorieSelected = [Int]()
    var categorieID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            let categories = (shop?.categories)!
            
            for categorie in categories{
                for item in categorie.items!{
                    if item.isPromo == true{
                        self.promoItems.append(item)
                        self.categorieSelected.append(categorie.id!)
                    }
                }
                for i in categorie.sizes!{
                    if i.dimension == nil {
                        self.sizes[i.id!] = "Normal"
                    } else {
                        self.sizes[i.id!] = i.dimension!
                    }
                }
            }
            
            self.indicator.stopAnimating()
            
            //Actualizamos la tabla para que se muestren los campos
            self.tableView.reloadData()
        }
    }
    
    //mostramos indicador de carga
    func showIndicator()
    {
        
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicator)
        
        indicator.startAnimating()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.promoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var path = [String]()
        var name = [String]()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPromo", for: indexPath) as! PromoItemMenu
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        for item in promoItems{
            path.append(item.imagePathName!)
            name.append(item.name!)
        }
        
        imageView.sd_setImage(with: URL(string: "http://media.disainin.com/tagwaiter/images/w500h500\(path[indexPath.row])"))
        
        cell.ProductoName.text = name[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.item = promoItems[indexPath.row]
        self.categorieID = categorieSelected[indexPath.row]
        
        performSegue(withIdentifier: "sendItemID", sender: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let view = segue.destination as! ModalVC
        
        view.item = item //Objeto item seleccionado
        view.sizes = sizes //Medidas de la categoria seleccionada
        view.categorieID = categorieID
    }


}
