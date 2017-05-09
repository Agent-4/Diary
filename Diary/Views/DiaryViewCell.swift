//
//  DiaryViewCell.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/10.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class DiaryViewCell: UITableViewCell {
    
    var diary_view: UIView!
    var date_day: UILabel!
    var date_year_month: UILabel!
    var diary_content: UILabel!
    var weatherIcon: UIImageView!
    var moodIcon: UIImageView!
    var diary_picture: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.9685775638, green: 0.97814399, blue: 0.9813601375, alpha: 1)
        setCellUI()
        
    }
    
    func setCellUI() {
        let WIDTH = UIScreen.main.bounds.width
        
        diary_view = UIView(frame: CGRect(x: 12, y: 5, width: WIDTH - 24, height: 100))
        diary_view.backgroundColor = UIColor.white
        diary_view.layer.cornerRadius = 4
        diary_view.layer.masksToBounds = true
        self.addSubview(diary_view)
        
        date_day = UILabel(frame: CGRect(x: 17, y: 7, width: 30, height: 28))
        date_day.textColor = #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)
        date_day.font = UIFont.systemFont(ofSize: 21)
        self.addSubview(date_day)
        
        date_year_month = UILabel(frame: CGRect(x: 111, y: 11, width: 57, height: 21))
        date_year_month.textColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        date_year_month.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(date_year_month)
        
        diary_content = UILabel(frame: CGRect(x: 19, y: 37, width: WIDTH - 108, height: 60))
        diary_content.textColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        diary_content.font = UIFont.systemFont(ofSize: 15)
        diary_content.numberOfLines = 0
        self.addSubview(diary_content)
        
        weatherIcon = UIImageView(frame: CGRect(x: 55, y: 13, width: 16, height: 16))
        self.addSubview(weatherIcon)
        
        moodIcon = UIImageView(frame: CGRect(x: 79, y: 11, width: 18, height: 18))
        self.addSubview(moodIcon)
        
        diary_picture = UIImageView(frame: CGRect(x: WIDTH - 81, y: 37, width: 60, height: 60))
        self.addSubview(diary_picture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
