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

class ModalVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var item: Item!
    var sizes = [Int:String]()
    var quantity = ["1","2","3","4","5","6","7","8","9","10"]
    
    @IBOutlet var imgModal: UIImageView!
    @IBOutlet var labelModal: UILabel!
    
    @IBOutlet var size1: UILabel!
    @IBOutlet var size2: UILabel!
    
    @IBOutlet var picker1: UIPickerView!
    @IBOutlet var picker2: UIPickerView!
    
    @IBAction func orderButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.delegate = self
        picker2.delegate = self
        
        labelModal.text = item.name
        
//        var count = item.price?.count
//
//        for i in  0...count!{
//            size1.text = "\(sizes[(item.price?[i].sizeId)!]!) - \((item.price?[i].price)!) €"
//            size2.text = "\(sizes[(item.price?[i].sizeId)!]!) - \((item.price?[i].price)!) €"
//        }
        
        size1.text = "\(sizes[(item.price?[0].sizeId)!]!) - \((item.price?[0].price)!) €"
        size2.text = "\(sizes[(item.price?[1].sizeId)!]!) - \((item.price?[1].price)!) €"
        
        imgModal.sd_setImage(with: URL(string: "http://media.disainin.com/tagwaiter/images/w264h264/\(item.imagePathName!)"))
        
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
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//    }
    
    @IBAction func closeModal(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
