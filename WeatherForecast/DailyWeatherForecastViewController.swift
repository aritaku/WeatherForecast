//
//  DailyWeatherForecastViewController.swift
//  WeatherForecast
//
//  Created by 有村琢磨 on 2016/02/08.
//  Copyright © 2016年 有村琢磨. All rights reserved.
//  use api from http://weather.livedoor.com/weather_hacks/webservice
//

import UIKit
import Alamofire
import SwiftyJSON

class DailyWeatherForecastViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel! //pop : probability of precipitation
    @IBOutlet weak var weatherImageView: UIImageView!

    
    let LivedoorWeatherServiceURL = "http://weather.livedoor.com/forecast/webservice/json/v1?"

    override func viewDidLoad() {
               super.viewDidLoad()
        
        getDailyWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getDailyWeather(){
        
        Alamofire.request(.GET, LivedoorWeatherServiceURL, parameters: ["city":400040]).responseJSON{ response in
            guard let object = response.result.value else {
                print("false")
                return
            }
            
            let json  = JSON(object)
            json.forEach { (_,String) in
                print(json["forecasts"][0])
                self.dateLabel.text = json["forecasts"][0]["date"].string
                self.weatherLabel.text = json["forecasts"][0]["telop"].string
//                let url :NSURL = NSURL(string: json["forecasts"][0]["image"]["url"].string!)!
//                let imageData :NSData = NSData(contentsOfURL: url)!
//                let image :UIImage = UIImage(data: imageData)!
//                self.weatherImageView = UIImageView(image: image)
                
            }
        }
    }
    
    

}
