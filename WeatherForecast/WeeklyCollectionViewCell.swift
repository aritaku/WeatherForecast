//
//  WeeklyCollectionViewCell.swift
//  WeatherForecast
//
//  Created by 有村琢磨 on 2016/02/10.
//  Copyright © 2016年 有村琢磨. All rights reserved.
//

import UIKit

class WeeklyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tenkou: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var minimum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
