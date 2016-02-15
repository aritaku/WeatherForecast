//
//  DailyWeatherForecastViewController.swift
//  WeatherForecast
//
//  Created by 有村琢磨 on 2016/02/08.
//  Copyright © 2016年 有村琢磨. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DailyWeatherForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var maxTemparatureLabel: UILabel!
    @IBOutlet weak var minimumTemparatureLabel: UILabel!
    
    let OpenWeatherMapURL = "http://api.openweathermap.org/data/2.5/forecast/daily?&units=metric&cnt=7&APPID=a95b3f19140f63337f067f78e5848566"
    let prefectures: NSArray =
    ["Hokkaido","Aomori","Iwate","Miyagi","Akita","Yamagata","Hukusima","Ibaragi","Totigi","Gunnma","Saitama","Tiba","Tokyo","Kanagawa","Niigata","Toyama","Ishikawa","Hukui","Yamanashi","Nagano","Gifu","Shizuoka","Aichi","Mie","Shiga","Kyoto","Osaka","Hyogo","Nara","Wakayama","Tottori","Shimane","Okayama","Hiroshima","Yamaguchi","Tokushima","Kagawa","Aichi","Kochi","Fukuoka","Saga","Nagasaki","Kumamoto","Oita","Miyazaki","Kagoshima","Okinawa"
    ]
    
    var iconName: String = ""
    
    var weatherInfo: [[String: String?]] = []
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView Initialize
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        let nibDaily :UINib = UINib(nibName: "WeeklyTableViewCell", bundle: nil)
        tableView.registerNib(nibDaily, forCellReuseIdentifier: "WeeklyTableViewCell")
        
        //CollectionView Initialize
        collectionView.delegate = self
        collectionView.dataSource = self
        cvLayout()
        let nibWeekly :UINib = UINib(nibName: "DailyCollectionViewCell", bundle: nil)
        collectionView.registerNib(nibWeekly, forCellWithReuseIdentifier: "DailyCollectionViewCell")
        
        self.title = appDelegate.city
    }
    
    
    override func viewWillAppear(animated: Bool) {
        getDailyWeatherJson(prefectures[appDelegate.row!] as! String)
        self.title = appDelegate.city
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //collection view layout
    func cvLayout(){
        let cvlayout = UICollectionViewFlowLayout()
        cvlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) //top, left, bottom, right
        cvlayout.minimumInteritemSpacing = 0.0
        cvlayout.minimumLineSpacing = 0.0
    }
    
    //get json
    func getDailyWeatherJson(city: String){
        
        
        Alamofire.request(.GET, OpenWeatherMapURL, parameters: ["q": city]).responseJSON{ response in
            guard let object = response.result.value else {
                print("false getting json")
                return
            }
            
            let json  = JSON(object)
            json.forEach { (_,String) in
                print(json)
                
//                for (var i = 0; i < 7; i++){
//                    let info: [String: String?] = [
//                        "main": json["list"][i]["weather"][0]["main"].string,
//                        "iconName": json["list"][i]["weather"][0]["icon"].string,
//                        "maxTemp": String(json["list"][i]["temp"]["max"].float),
//                        "minTemp": Strng(json["list"][i]["temp"]["min"].float)
//                    ]
//                    self.weatherInfo.append(info)
//                }
//            }
                //icon setting
                self.iconName = json["list"][0]["weather"][0]["icon"].string!
                let weatherIconURL = "http://openweathermap.org/img/w/\(self.iconName).png"
                let url: NSURL = NSURL(string: weatherIconURL)!
                let imageData: NSData = NSData(contentsOfURL: url)!
                let image: UIImage = UIImage(data: imageData)!
                self.weatherImageView.image = image
                
                //labels setting
                self.minimumTemparatureLabel.text = "\(json["list"][0]["temp"]["min"].float!)℃"
                self.maxTemparatureLabel.text = "\(json["list"][0]["temp"]["max"].float!)℃"
                self.weatherLabel.text = json["list"][0]["weather"][0]["main"].string!

            }
        }
    }
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeeklyTableViewCell", forIndexPath: indexPath) as! WeeklyTableViewCell
        
        //configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DailyCollectionViewCell", forIndexPath: indexPath) as! DailyCollectionViewCell
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
