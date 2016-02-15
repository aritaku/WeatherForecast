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
    
    var iconName: String = ""
    var cityName: String = ""

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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        getDailyWeather()
        self.title = "現在地"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //collection view layout
    func cvLayout(){
        let cvlayout = UICollectionViewFlowLayout()
        cvlayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 0) //top, left, bottom, right
        cvlayout.minimumInteritemSpacing = 0.0
        cvlayout.minimumLineSpacing = 0.0
    }
    
    //get json
    func getDailyWeather(){
        
        cityName = "Tokyo,jp"
        
        Alamofire.request(.GET, OpenWeatherMapURL, parameters: ["q": cityName]).responseJSON{ response in
            guard let object = response.result.value else {
                print("json false")
                return
            }
            
            let json  = JSON(object)
            json.forEach { (_,String) in
                print(json)
                self.iconName = json["list"][0]["weather"][0]["icon"].string!
                let weatherIconURL = "http://openweathermap.org/img/w/\(self.iconName).png"
                let url: NSURL = NSURL(string: weatherIconURL)!
                let imageData: NSData = NSData(contentsOfURL: url)!
                let image: UIImage = UIImage(data: imageData)!
                self.weatherImageView.image = image
                self.title = self.cityName
                self.minimumTemparatureLabel.text = "\(json["list"][0]["temp"]["min"].float!)℃"
                self.maxTemparatureLabel.text = "\(json["list"][0]["temp"]["max"].float!)℃"
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
