//
//  LineView.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/14.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.beginPath()
        context.move(to: CGPoint(x:0,y:0))
        context.addLine(to: CGPoint(x:UIScreen.main.bounds.width,y:0))
        context.setLineWidth(0.5)
        context.setStrokeColor(UIColor.init(red: 160/255, green: 160/255, blue: 160/255, alpha: 0.5).cgColor)
        context.closePath()
        context.strokePath()
    }

}
