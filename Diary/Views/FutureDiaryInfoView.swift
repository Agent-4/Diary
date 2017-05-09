//
//  FutureDiaryInfoView.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/13.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

// 协议
protocol InfoViewDelegate: NSObjectProtocol {
    func goBack()
}

class FutureDiaryInfoView: UIView {
    weak var delegate: InfoViewDelegate?
    
    @IBOutlet weak var futureDate: UILabel!
    
    
    @IBAction func done(_ sender: Any) {
        delegate?.goBack()
        self.hide()
    }

}
