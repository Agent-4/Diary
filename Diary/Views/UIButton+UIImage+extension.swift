//
//  UIButton+extension.swift
//  Diary
//
//  Created by moxiaohao on 2016/11/24.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init (title: String?, fontSize: CGFloat = 13, color: UIColor = UIColor.darkGray, image: String? = nil, bgImage: String? = nil, target: Any? = nil, selector: Selector? = nil, event: UIControlEvents = .touchUpInside) {
        
        self.init()
        
        // 设置title
        if let title = title {
            
            self.setTitle(title, for: .normal)
            self.setTitleColor(color, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        // 设置图片
        if let image = image {
            self.setImage(UIImage(named: image), for: .normal)
            self.setImage(UIImage(named: "\(image)_highlighted"), for: .highlighted)
        }
        
        // 设置背景图片
        if let bgImage = bgImage {
            self.setBackgroundImage(UIImage(named: bgImage), for: .normal)
            self.setBackgroundImage(UIImage(named: "\(bgImage)_highlighted"), for: .highlighted)
        }
        
        // 给button加点击事件
        if let target = target, let selector = selector {
            self.addTarget(target, action: selector, for: event)
        }
    }
}


extension UIImage {
    
    /// 绘制图像
    ///
    /// - Parameters:
    ///   - isCornored: 是否是圆角
    ///   - size: 绘制的大小
    ///   - backgroundColor: 背景颜色
    func wb_createImage(isCornored: Bool = true, size: CGSize = CGSize.zero, backgroundColor: UIColor = UIColor.white) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        // 1.开启上下文
        UIGraphicsBeginImageContext(size)
        
        // 2. 设置颜色
        backgroundColor.setFill()
        
        // 3. 颜色填充
        UIRectFill(rect)
        
        // 4. 切圆角, 添加裁切路径
        if isCornored {
            //切回角
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
        }
        
        // 5. 图像绘制
        self.draw(in: rect)
        
        // 6. 获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 7.关闭上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// 绘制图像
    ///
    /// - Parameters:
    ///   - isCornored: 是否是圆角
    ///   - size: 绘制的大小
    ///   - backgroundColor: 背景颜色
    func wb_asyncCreateImage(isCornored: Bool = true, size: CGSize = CGSize.zero, backgroundColor: UIColor = UIColor.white, callBack: @escaping (_ image: UIImage)->()) {
        
        // 在子线程中处理图片
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            // 1.开启上下文
            UIGraphicsBeginImageContext(size)
            
            // 2. 设置颜色
            backgroundColor.setFill()
            
            // 3. 颜色填充
            UIRectFill(rect)
            
            // 4. 切圆角, 添加裁切路径
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
            
            // 5. 图像绘制
            self.draw(in: rect)
            
            // 6. 获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            // 7.关闭上下文
            UIGraphicsEndImageContext()
            
            // 在主线程回调图片
            DispatchQueue.main.async {
                callBack(image!)
            }
        }
        
    }
}
