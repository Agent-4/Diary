//
//  DiscoverDiaryTableViewCell.swift
//  Diary
//
//  Created by 莫晓豪 on 2017/4/27.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class DiscoverDiaryTableViewCell: UITableViewCell {
    
    var diary_view: UIView!
    var user_avatar: UIImageView!
    var user_name: UILabel!
    var diary_content: UILabel!
    var likeBtn: UIButton!
    var likeNumber: UILabel!
    var diaryDate: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.9685775638, green: 0.97814399, blue: 0.9813601375, alpha: 1)
        setUI()
        
    }
    
    func setUI() {
        let WIDTH = UIScreen.main.bounds.width
        
        diary_view = UIView(frame: CGRect(x: 0, y: 5, width: WIDTH, height: 150))
        diary_view.backgroundColor = UIColor.white
        self.addSubview(diary_view)
        
        user_avatar = UIImageView(frame: CGRect(x: 14, y: 18, width: 26, height: 26))
        user_avatar.layer.cornerRadius = 13
        user_avatar.layer.masksToBounds = true
        self.addSubview(user_avatar)
        
        user_name = UILabel(frame: CGRect(x: 50, y: 21, width: 220, height: 21))
        user_name.textColor = #colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6235294118, alpha: 1)
        user_name.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(user_name)
        
        diary_content = UILabel(frame: CGRect(x: 30, y: 55, width: WIDTH - 45, height: 70))
        diary_content.textColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        diary_content.font = UIFont.systemFont(ofSize: 14)
        diary_content.numberOfLines = 0
        self.addSubview(diary_content)
        
        diaryDate = UILabel(frame: CGRect(x: 16, y: 127, width: 105, height: 21))
        diaryDate.textColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        diaryDate.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(diaryDate)
        
        likeNumber = UILabel(frame: CGRect(x: WIDTH - 66, y: 128, width: 25, height: 21))
        likeNumber.textColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        likeNumber.font = UIFont.systemFont(ofSize: 11)
        likeNumber.textAlignment = .right
        self.addSubview(likeNumber)
        
        likeBtn = UIButton(frame: CGRect(x: WIDTH - 42, y: 121, width: 35, height: 35))
        likeBtn.setImage(UIImage(named: "like.png"), for: .normal)
        likeBtn.setImage(UIImage(named: "likeSelected.png"), for: .highlighted)
        likeBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9)
//        likeBtn.addTarget(self, action: #selector(likeClicked(index:)), for: .touchUpInside)
        self.addSubview(likeBtn)
    
    }
    
//    func likeClicked(index: UIButton) {
//        print("点击了 like \(index.tag)")
//        index.setImage(UIImage(named: "likeSelected.png"), for: .normal)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
