//
//  SkinCollectionReusableView.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/23.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class SkinCollectionReusableView: UICollectionReusableView {
    
    var footerTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        footerTitle = UILabel(frame: CGRect(x: 9, y: self.frame.height/2 - 11, width: self.frame.width - 18, height: 21))
        footerTitle?.textColor = UIColor.darkGray
        footerTitle?.textAlignment = .center
        footerTitle?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(footerTitle!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
