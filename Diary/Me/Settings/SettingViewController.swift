//
//  SettingViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/10/18.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {

    var settingNavigationBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        self.view.backgroundColor = UIColor.white
        
        createSettingNavigationBar()
                
    }
    //创建导航栏
    func createSettingNavigationBar() {
        settingNavigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        settingNavigationBar?.isTranslucent = false
        settingNavigationBar?.barTintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        settingNavigationBar?.tintColor = UIColor.white
        settingNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)]
        settingNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        settingNavigationBar?.shadowImage = UIImage()
        settingNavigationBar?.pushItem(makeSettingNavBar(), animated: true)
        self.view.addSubview(settingNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func makeSettingNavBar() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem(title: "",style: .plain, target: self, action: #selector(SettingViewController.backToMe))
        leftBtn.image = UIImage(named: "back_white")
        navigationItem.title = "设置"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
