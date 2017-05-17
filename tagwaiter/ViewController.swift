//
//  ViewController.swift
//  tagwaiter
//
//  Created by Manu on 30/3/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import CoreLocation //obtener localizacion usuario
import Alamofire //hacer consultas al servidor

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var qrCode: String?
    var haveQrCode = false
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBAction func buttonQR(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
        
        if haveQrCode == true {
            var isValid = verifyConnection(code: qrCode!, latitud: currentLocation.coordinate.latitude, longitud: currentLocation.coordinate.longitude)
            
            print("isValid: \(isValid)")
            if isValid == true
            {
                print("Correcto")
            } else if isValid == false{
                
                let alert = UIAlertController(title: "No se ha podido conecctar", message: "No se ha podido conectar, puede que la mesa esté ocupada", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Probar de nuevo", style: .default, handler: nil))
                
                present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //Set to white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    
    func verifyConnection(code: String, latitud: Double, longitud: Double) -> Bool
    {
        var conn = false
        
        Alamofire.request("http://api.disainin.com/foodtags/1/access/qr/\(code)/\(latitud)/\(longitud)").responseJSON { response in
            
            if let JSON = response.result.value as? [String: Any] {
                if let name = JSON["name"] as? String {
                    UserDefaults.standard.set(name, forKey: "shopName")
                }
                if let sessionId = JSON["sessionId"] as? String {
                    UserDefaults.standard.set(sessionId, forKey: "sessionId")
                }
                if let shopId = JSON["shopId"] as? String {
                    UserDefaults.standard.set(shopId, forKey: "shopId")
                }
                if let token = JSON["token"] as? String {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                if let valid = JSON["valid"] as? Bool {
                    print("Valid: \(valid)")
                    UserDefaults.standard.set(valid, forKey: "valid")
                    if valid == true {conn = true}
                }
            }
        }
        print("Conn: \(conn)")
        return conn
    }
    
}

