//
//  ModalVC.swift
//  tagwaiter
//
//  Created by Manu on 27/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import RealmSwift

class ModalVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var item: Item!
    var sizes = [Int:String]()
    var categorieID = 0
    var quantity = ["0","1","2","3","4","5","6","7","8","9","10"]
    
    @IBOutlet var imgModal: UIImageView!
    @IBOutlet var labelModal: UILabel!
    
    @IBOutlet var size1: UILabel!
    @IBOutlet var size2: UILabel!
    
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    
    var sesionO = SessionOrder()
    var sesionOI = SessionOrderItem()
    var sesionOTS1 = SessionOrderItemSize()
    var sesionOTS2 = SessionOrderItemSize()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        picker1.delegate = self
        picker2.delegate = self
        
        labelModal.text = item.name
        
        
        if item.price?.count == 1 {
            size2.isHidden = true
            picker2.isHidden = true
            
            size1.text = "\(sizes[(item.price?[0].sizeId)!]!) - \((item.price?[0].price)!) €"
        } else {
            size1.text = "\(sizes[(item.price?[0].sizeId)!]!) - \((item.price?[0].price)!) €"
            size2.text = "\(sizes[(item.price?[1].sizeId)!]!) - \((item.price?[1].price)!) €"
        }
        
        
        imgModal.sd_setImage(with: URL(string: "http://media.disainin.com/tagwaiter/images/w264h264/\(item.imagePathName!)"))
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //SessionOrderItemSizes
        if pickerView == picker1{
            sesionOTS1.sizeId = (item.price?[0].sizeId)!
            sesionOTS1.quantity = Int(quantity[row])!
        }else if pickerView == picker2{
            sesionOTS2.sizeId = (item.price?[1].sizeId)!
            sesionOTS2.quantity = Int(quantity[row])!
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1{
            return quantity.count
        }else if pickerView == picker2{
            return quantity.count
        }
        return quantity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1{
            return quantity[row]
        }else if pickerView == picker2{
            return quantity[row]
        }
        return quantity[row]
    }
    
    @IBAction func sendOrder(_ sender: UIButton) {
        
        if sesionOTS1.quantity == 0 && sesionOTS2.quantity == 0{
            alertNoQuantity()
        } else {
            let realm = try! Realm()
            
            //SessionOrderItem
            sesionOI.categoryId = categorieID
            sesionOI.observations = ""
            sesionOI.itemId = item.id!
            sesionOI.sizes.append(sesionOTS1)
            sesionOI.sizes.append(sesionOTS2)
            
            //SessionOrder
            sesionO.items.append(sesionOI)
            sesionO.visible = true
            sesionO.date = Double(NSDate().timeIntervalSince1970)
            
            //Session
            sesion.orders.append(sesionO)
            sesion.token = "\(UserDefaults.standard.value(forKey: "token")!)"
            
            print("4 ->\(sesion)")
            
            try! realm.write{
                realm.add(sesion)
                print("SUCESS")
                close()
            }
        }
    }
    
    
    @IBAction func closeModal(_ sender: UIButton) {
        close()
    }
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    func alertNoQuantity(){
        let alert = UIAlertController(title: "Cantidad erronea", message: "Necesita añadir alguna cantidad para poder pedir", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
