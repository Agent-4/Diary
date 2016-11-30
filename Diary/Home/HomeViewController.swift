//
//  HomeViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/27.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        self.tabBarController?.tabBar.tintColor = UIColor (colorLiteralRed: 50/255, green: 205/255, blue: 50/255, alpha: 1)
        
        setTabbarShadow()
        
    }
    
    //去除tabbar顶部黑线，自定义设置tabBar分割线的样式,换成阴影
    func setTabbarShadow() {
        
        //去除tabbar顶部黑线,换成阴影
        self.tabBarController?.tabBar.shadowImage = UIImage(named: "tabbar_shadow")
        //必须要初始化tabbar背景图片
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        //设置tabbar背景颜色为白色
        self.tabBarController?.tabBar.backgroundColor = UIColor.white//#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
//        //绘阴影分割线
//        let lineShadow = CGRect(x: 0,y: 0, width: self.view.frame.width, height: 0.5)
//        UIGraphicsBeginImageContext(lineShadow.size)
//        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(UIColor.init(red: 160/255, green: 160/255, blue: 160/255, alpha: 0.4).cgColor)
//        context?.setAlpha(0.6)
//        context?.setShadow(offset: CGSize(width: 320, height: 0.5), blur: CGFloat(UIBlurEffectStyle.light.rawValue), color: UIColor.lightText.cgColor)
//        context?.fill(lineShadow)
//        let lineimg = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        //        //去navigationBar黑线
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = lineimg
        
//        //去除tabbar黑线,换成其它样式
//        self.tabBarController?.tabBar.shadowImage = lineimg
//        self.tabBarController?.tabBar.backgroundImage = UIImage.init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

