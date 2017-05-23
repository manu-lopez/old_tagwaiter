//
//  destacadosTVC.swift
//  tagwaiter
//
//  Created by Manu on 21/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class destacadosTVC: UIViewController, UITableViewDelegate {
    
    let url = "http://api.disainin.com/foodtags/1/shop"
    let header: HTTPHeaders = [
        "Authorization": "\(UserDefaults.standard.value(forKey: "token")!)"
    ]
    
    override func viewDidLoad() {
        getDataFromDB()
    }
    
    func getDataFromDB(){
        
        Alamofire.request(url, headers: header).responseObject { (response: DataResponse<Category>) in
            
            let weatherResponse = response.result.value
            print(weatherResponse?.id)
            
            if let threeDayForecast = weatherResponse?.sizes{
                for forecast in threeDayForecast {
                    print(forecast.id)
                    print(forecast.dimension)
                }
            }
        }
    }
}
