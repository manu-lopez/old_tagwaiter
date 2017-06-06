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
import RealmSwift

class MenuVC: UITableViewController {
    
    //Cabezera y URL
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
                "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]

    var categories = [Category]() //Objeto con todos los datos de las categorias
    
    var categorieSelected: Category! //objeto con la categoria que pasamos a siguiente view
    
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        showIndicator()
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.categories = (shop?.categories)!
            
            
            self.indicator.stopAnimating()
            
            //Actualizamos la tabla para que se muestren los campos
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var name = [String]()
        
        for categorie in categories {
            for item in categorie.name!{
                if item.language == UserDefaults.standard.value(forKey: "lang") as? String{
                    name.append(item.text!)
                }
            }
        }
        cell.textLabel?.text = name[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.categorieSelected = categories[indexPath.row]
        
        performSegue(withIdentifier: "sendCategorieID", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let view = segue.destination as! MenuCategorieVC
        
        view.categorie = categorieSelected
    }
    
    //mostramos indicador de carga
    func showIndicator()
    {
        
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicator)
        
        indicator.startAnimating()
    }
    
    @IBAction func callWaiter(_ sender: UIBarButtonItem) {
        Alamofire.request("http://api.disainin.com/foodtags/1/action/call/start", headers: header).responseJSON { response in
            if let resultado = response.result.value {
                self.alertCallWaiter()
            }
        }
    }
    
    func alertCallWaiter(){
        let alert = UIAlertController(title: "Llamando al camarero", message: "El camarero le atendera en unos instantes", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    
}
