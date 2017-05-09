//
//  MoreFeaturesViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/12.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class MoreFeaturesViewController: UIViewController {
    var MoreNavigationBar: UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createSettingNavigationBar()
        
        let frame = self.view.frame
        let moreView = UIImageView(frame: CGRect(x: 40, y: (frame.height - 64)/2 - (frame.width - 80)/2, width: frame.width - 80, height: frame.width - 80))
        moreView.image = UIImage(named: "more_features.png")
        moreView.contentMode = .scaleToFill
        self.view.addSubview(moreView)
    }
    
    //创建导航栏
    func createSettingNavigationBar() {
        MoreNavigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        MoreNavigationBar?.isTranslucent = false
        MoreNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        MoreNavigationBar?.tintColor = UIColor.white
        MoreNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        MoreNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        MoreNavigationBar?.shadowImage = UIImage()
        MoreNavigationBar?.pushItem(createSettingBarItem(), animated: true)
        self.view.addSubview(MoreNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func createSettingBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(MoreFeaturesViewController.backToMe))
        navigationItem.title = "更多功能"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: false)
        return navigationItem
    }
    //返回“我的”页面
    func backToMe() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //设置statusBar颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
