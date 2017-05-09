//
//  SkinCollectionViewCell.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/23.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class SkinCollectionViewCell: UICollectionViewCell {
    
    var title: UILabel?
    
    var selectImg: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title = UILabel(frame: CGRect(x: self.frame.width / 2 - 21, y: self.frame.height - 31, width: 42, height: 21))
        title?.textColor = UIColor.white
        title?.textAlignment = .center
        title?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(title!)
        
        selectImg = UIImageView.init(frame: CGRect(x: self.frame.width - 23, y: 5, width: 18, height: 18))
        self.addSubview(selectImg!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
