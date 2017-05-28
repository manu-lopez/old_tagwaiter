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
    var categorie: Category!
    var items = [Item]()
    var sizes = [Int:String]()
    
    var item: Item! //objecto item seleccionado para enviar
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //se cogen los tamaños de las categorias !!FALLA!!
        for a in categorie.sizes!{
            if a.dimension == nil {
             sizes[a.id!] = "Normal"
            }else {
            sizes[a.id!] = a.dimension!
            }
        }
        
        //Colocamos el nombre de la categoria
        for i in categorie.name!{
            if i.language == UserDefaults.standard.value(forKey: "lang") as? String{
                self.title = i.text
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categorie.items?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemMenu", for: indexPath) as! ItemMenu
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.sd_setImage(with: URL(string: "http://media.disainin.com/tagwaiter/images/w500h500\((categorie.items?[indexPath.row].imagePathName)!)"))
        
        cell.ProductName.text = categorie.items?[indexPath.row].name!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.item = categorie.items?[indexPath.row]
        
        performSegue(withIdentifier: "sendItemID", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let view = segue.destination as! ModalVC
        
        view.item = item //Objeto item seleccionado
        view.sizes = sizes //Medidas de la categoria seleccionada
    }
    
}
