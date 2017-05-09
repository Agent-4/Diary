//
//  WeatherAndMoodView.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/10.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

// 协议
protocol weatherAndMoodDelegate: NSObjectProtocol {
    func setWeatherAndMood(weatherSelected: Int, moodSelected: Int)
}

class WeatherAndMoodView: UIView {
    weak var delegate: weatherAndMoodDelegate?
    
    let weatherInfo = ["晴朗","多云","刮风","小雨","大雨","闪电","降雪","雾"]
    let moodInfo = ["高兴","平淡","非常高兴","酷","不高兴","疑惑","悲伤","生气"]
    // 文本提示
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    // 天气按钮
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var cloudButton: UIButton!
    @IBOutlet weak var windButton: UIButton!
    @IBOutlet weak var drizzleButton: UIButton!
    @IBOutlet weak var rainButton: UIButton!
    @IBOutlet weak var ligtningButton: UIButton!
    @IBOutlet weak var sonwButton: UIButton!
    @IBOutlet weak var fogButton: UIButton!
    // 心情按钮
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var veryHappyButton: UIButton!
    @IBOutlet weak var coolButton: UIButton!
    @IBOutlet weak var unhappyButton: UIButton!
    @IBOutlet weak var wonderingButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    
    var weatherSelectedIndex: Int = 8
    var moodSelectedIndex: Int = 8
    
    // 天气选择 点击事件
    @IBAction func weatherSelected(_ sender: UIButton) {
        weatherLabel.text = weatherInfo[sender.tag]
        weatherSelectedIndex = sender.tag
        setButtonSelectedImage()
    }
    
    // 心情选择 点击事件
    @IBAction func moodSelected(_ sender: UIButton) {
        moodLabel.text = moodInfo[sender.tag]
        moodSelectedIndex = sender.tag
        setMoodSelectedImage()
    }
    
    // 天气选中图片设置
    func setButtonSelectedImage() {
        sunButton.setImage(UIImage(named: "sun.png"), for: .normal)
        cloudButton.setImage(UIImage(named: "cloud.png"), for: .normal)
        windButton.setImage(UIImage(named: "wind.png"), for: .normal)
        drizzleButton.setImage(UIImage(named: "drizzle.png"), for: .normal)
        rainButton.setImage(UIImage(named: "rain.png"), for: .normal)
        ligtningButton.setImage(UIImage(named: "lightning.png"), for: .normal)
        sonwButton.setImage(UIImage(named: "snow.png"), for: .normal)
        fogButton.setImage(UIImage(named: "fog.png"), for: .normal)
        switch weatherSelectedIndex {
            case 0: sunButton.setImage(UIImage(named: "sunSelected.png"), for: .normal)
            case 1: cloudButton.setImage(UIImage(named: "cloudSelected.png"), for: .normal)
            case 2: windButton.setImage(UIImage(named: "windSelected.png"), for: .normal)
            case 3: drizzleButton.setImage(UIImage(named: "drizzleSelected.png"), for: .normal)
            case 4: rainButton.setImage(UIImage(named: "rainSelected.png"), for: .normal)
            case 5: ligtningButton.setImage(UIImage(named: "lightningSelected.png"), for: .normal)
            case 6: sonwButton.setImage(UIImage(named: "snowSelected.png"), for: .normal)
            case 7: fogButton.setImage(UIImage(named: "fogSelected.png"), for: .normal)
            default: break
        }
    }
    
    // 心情选中图片设置
    func setMoodSelectedImage() {
        happyButton.setImage(UIImage(named: "happy.png"), for: .normal)
        neutralButton.setImage(UIImage(named: "neutral.png"), for: .normal)
        veryHappyButton.setImage(UIImage(named: "veryHappy.png"), for: .normal)
        coolButton.setImage(UIImage(named: "cool.png"), for: .normal)
        unhappyButton.setImage(UIImage(named: "unhappy.png"), for: .normal)
        wonderingButton.setImage(UIImage(named: "wondering.png"), for: .normal)
        sadButton.setImage(UIImage(named: "sad.png"), for: .normal)
        angryButton.setImage(UIImage(named: "angry.png"), for: .normal)
        
        switch moodSelectedIndex {
            case 0: happyButton.setImage(UIImage(named: "happySelected.png"), for: .normal)
            case 1: neutralButton.setImage(UIImage(named: "neutralSelected.png"), for: .normal)
            case 2: veryHappyButton.setImage(UIImage(named: "veryHappySelected.png"), for: .normal)
            case 3: coolButton.setImage(UIImage(named: "coolSelected.png"), for: .normal)
            case 4: unhappyButton.setImage(UIImage(named: "unhappySelected.png"), for: .normal)
            case 5: wonderingButton.setImage(UIImage(named: "wonderingSelected.png"), for: .normal)
            case 6: sadButton.setImage(UIImage(named: "sadSelected.png"), for: .normal)
            case 7: angryButton.setImage(UIImage(named: "angrySelected.png"), for: .normal)
            default: break
        }
    }
    
    // 完成
    @IBAction func SSS(_ sender: Any) {
        delegate?.setWeatherAndMood(weatherSelected: weatherSelectedIndex, moodSelected: moodSelectedIndex)
        self.hide()
        
    }
    
}
