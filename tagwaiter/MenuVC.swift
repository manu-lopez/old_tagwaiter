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

class MenuVC: UITableViewController {
    
    //Cabezera y URL
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    
    var categories = [Category]() //Objeto con todos los datos de las categorias
    var numCategories = 0 //Cantidad de categorias que tiene
    var categorieName = [String]() //Conjunto de categorias del lugar
    var nameSelected = "" //Nombre categoria que pasamos a otra view
    var idSelected = 0 //Id categoria seleccionada
    
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.categories = (shop?.categories)!
            self.numCategories = (shop?.categories?.count)!
            
            
            for categorie in self.categories{ //recorremos las distintas categorias
                for data in categorie.name!{ //recorremos los datos de una categoria
                    // si el lenguaje es el mismo que el de nuestro dispositivo, nos muestra el nombre en ese idioma
                    if data.language == UserDefaults.standard.value(forKey: "lang") as? String{
                        //guardamos los nombres en un array para mostralos luego
                        self.categorieName.append(data.text!)
                    
                    }
                }
            }
            
            self.indicator.stopAnimating()
            
            //Actualizamos la tabla para que se muestren los campos
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCategories
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = categorieName[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nameSelected = categorieName[indexPath.row]
        self.idSelected = categories[indexPath.row].id!
        
        performSegue(withIdentifier: "sendCategorieID", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! MenuCategorieVC
        
        view.categorieID = idSelected //ID categoria seleccionada
        view.categorieName = nameSelected //Nombre categoria seleccionada

    }
    
    //mostramos indicador de carga
    func showIndicator(){
        
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicator)
        
        indicator.startAnimating()
    }
}
