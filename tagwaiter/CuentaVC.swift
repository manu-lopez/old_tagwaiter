//
//  CuentaVC.swift
//  tagwaiter
//
//  Created by Manu on 6/6/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CuentaVC: UITableViewController {
    
    @IBOutlet var total: UILabel!
    
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    var categories = [Category]()
    var sesion: Session!
    var info = [String]()
    var totalprice: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getdata()
    }
    
    func getdata(){
        info = []
        var total: Float = 0
        Alamofire.request("http://api.disainin.com/foodtags/1/shop", headers: header).responseObject { (response: DataResponse<Shop>) in
            
            let shop = response.result.value
            self.categories = (shop?.categories)!
            
        }
        
        Alamofire.request("http://api.disainin.com/foodtags/1/session", headers: header).responseObject { (response: DataResponse<Session>) in
            self.sesion = response.result.value
            
            for items in self.sesion.orders{
                for itemSes in items.items{
                    for category in self.categories{
                        if category.id == itemSes.categoryId{
                            for itemsC in category.items!{
                                if itemsC.id == itemSes.itemId{
                                    for i in itemsC.price!{
                                        for data in itemSes.sizes{
                                            if i.sizeId == data.sizeId{
                                                self.info.append("\(itemsC.name!) - \(i.price!) € x \(data.quantity)")
                                                total+=(i.price! * Float(data.quantity))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            self.total.text = "\(total) €"
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.info[indexPath.row]
        return cell
    }
    
    @IBAction func askBill(_ sender: UIBarButtonItem) {
        if self.info.count > 0{
            let alert = UIAlertController(title: "Pedir Cuenta", message: "¿Has terminado de comer?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                
                Alamofire.request("http://api.disainin.com/foodtags/1/action/ask/start", headers: self.header).responseJSON { response in
                    if let resultado = response.result.value {
                        self.alertaskbill()
                    }
                }
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            alerNoItem()
        }
    }
    
    func alertaskbill(){
        let alert = UIAlertController(title: "Le estamos preparando la cuenta", message: "Gracias por visitarnos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let ScanQr = storyBoard.instantiateViewController(withIdentifier: "ScanQr")
            self.present(ScanQr, animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alerNoItem(){
        let alert = UIAlertController(title: "No has pedido nada", message: "Si quieres cerrar la cuenta, llame al camarero", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
