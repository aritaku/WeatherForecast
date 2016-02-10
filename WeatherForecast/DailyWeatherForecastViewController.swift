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

class DailyWeatherForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let LivedoorWeatherServiceURL = "http://weather.livedoor.com/forecast/webservice/json/v1?"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //let nibWeekly :UINib = UINib(nibName: "WeeklyCollectionViewCell", bundle: nil)
        //let nibDaily :UINib = UINib(nibName: "DailyTableViewCell", bundle: nil)
        
        //collectionView.registerNib(nibWeekly, forCellWithReuseIdentifier: "WeeklyCollectionViewCell")
        //tableView.registerNib(nibDaily, forCellReuseIdentifier: "DailyTableViewCell")
        
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
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DailyTableViewCell", forIndexPath: indexPath) as! DailyTableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
//    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WeeklyCell", forIndexPath: indexPath) as! WeeklyCollectionViewCell
        configureCell(cell, forItemAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UICollectionViewCell, forItemAtIndexPath: NSIndexPath) {
        
    }
    
    /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "WeeklyCell", forIndexPath: indexPath) as! WeeklyCollectionViewCell
        return view
    }
    */
    
    

}
