//
//  ViewController.swift
//  WeatherForecast
//
//  Created by 有村琢磨 on 2016/02/08.
//  Copyright © 2016年 有村琢磨. All rights reserved.
//

import UIKit

class LocationSettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var locationPickerView: UIPickerView!
    private var preSelectedLb:UILabel!
    private let prefectures: NSArray =
    ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationPickerView.delegate = self
        self.locationPickerView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prefectures.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = prefectures[row] as! String
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HiraKakuProN-W3", size: 20.0)!,NSForegroundColorAttributeName:UIColor.grayColor()])
        
        // fontサイズ、テキスト
        pickerLabel.attributedText = myTitle
        // 中央寄せ ※これを指定しないとセンターにならない
        pickerLabel.textAlignment = NSTextAlignment.Center
        pickerLabel.frame = CGRectMake(0, 0, 200, 30)
        // ラベルを角丸に
        pickerLabel.layer.masksToBounds = true
        pickerLabel.layer.cornerRadius = 5.0
        
        // 既存ラベル、選択状態のラベルが存在している
        if let lb = pickerView.viewForRow(row, forComponent: component) as? UILabel,
            let selected = self.preSelectedLb {
                // 設定
                self.preSelectedLb = lb
                self.preSelectedLb.backgroundColor = UIColor.orangeColor()
                self.preSelectedLb.textColor = UIColor.whiteColor()
        }
        
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(prefectures[row])")
        
        // 選択状態のラベルを代入
        self.preSelectedLb = pickerView.viewForRow(row, forComponent: component) as! UILabel
        // ピッカーのリロードでviewForRowが呼ばれる
        pickerView.reloadComponent(component)
    }
    

}

