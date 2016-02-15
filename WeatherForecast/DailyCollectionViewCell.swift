//
//  WeeklyCollectionViewCell.swift
//  WeatherForecast
//
//  Created by 有村琢磨 on 2016/02/10.
//  Copyright © 2016年 有村琢磨. All rights reserved.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tenkouLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minimumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
