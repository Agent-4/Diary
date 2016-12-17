//
//  AboutAppViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/8.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {
    var aboutAppNavigationBar: UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        createAboutAppNavigationBar()
        aboutThisApp()
        
    }
    func aboutThisApp() {
        
        let appIcon = UIImageView(frame: CGRect(x: self.view.frame.width / 2 - 45, y: self.view.frame.height / 2 - 130, width: 90, height: 90))
        appIcon.image = UIImage(named: "ThisApp")
        appIcon.contentMode = .scaleAspectFill
        appIcon.layer.cornerRadius = 16
        appIcon.layer.borderColor = UIColor.white.cgColor
        appIcon.layer.borderWidth = 1.5
        appIcon.clipsToBounds = true
        self.view.addSubview(appIcon)
        
        let versionLabel = UILabel.init(frame: CGRect(x: 0, y: self.view.frame.height/2 - 40, width: self.view.frame.width, height: 24))
        versionLabel.text = "Version 1.0"
        versionLabel.textColor = #colorLiteral(red: 1, green: 0.2855349779, blue: 0.1690564752, alpha: 1)
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(versionLabel)
        
        let appIcon2 = UIImageView(frame: CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2, width: 200, height: 200))
        appIcon2.image = UIImage(named: "memory")
        appIcon2.contentMode = .scaleAspectFill
        self.view.addSubview(appIcon2)
        
        //用户条款链接
        let TermsLabel = UILabel.init(frame: CGRect(x: self.view.frame.width/2 - 25, y: self.view.frame.height - 50, width: 50, height: 20))
        TermsLabel.font = UIFont.systemFont(ofSize: 11)
        TermsLabel.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        TermsLabel.textAlignment = .center
        TermsLabel.text = "用户条款"
        TermsLabel.isUserInteractionEnabled = true
        self.view.addSubview(TermsLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTermsLabel))
        TermsLabel.addGestureRecognizer(tap)
        
        let CopyrightLabel = UILabel.init(frame: CGRect(x: 0, y: self.view.frame.height - 30, width: self.view.frame.width, height: 24))
        CopyrightLabel.text = "Copyright © 2017 moxiaohao All rights reseved."
        CopyrightLabel.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        CopyrightLabel.textAlignment = .center
        CopyrightLabel.font = UIFont.systemFont(ofSize: 11)
        self.view.addSubview(CopyrightLabel)
    }
    
    //用户条款点击
    func clickTermsLabel(){
        print("点击了用户条款！")
        let viewController = UserTermsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //创建导航栏
    func createAboutAppNavigationBar() {
        aboutAppNavigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        aboutAppNavigationBar?.isTranslucent = false
        aboutAppNavigationBar?.barTintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        aboutAppNavigationBar?.tintColor = UIColor.white
        aboutAppNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)]
        aboutAppNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        aboutAppNavigationBar?.shadowImage = UIImage()
        aboutAppNavigationBar?.pushItem(makeAboutAppNavBar(), animated: true)
        self.view.addSubview(aboutAppNavigationBar!)
    }
    
    //设置导航栏左右按钮、标题
    func makeAboutAppNavBar() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSetting))
        let rightBtn = UIBarButtonItem.init(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareAppToFriend))
        navigationItem.title = "关于留忆"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationItem.setRightBarButton(rightBtn, animated: true)
        return navigationItem
    }
    
    //返回“设置”页面
    func backToSetting() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //分享APP
    func shareAppToFriend() {
        print("点击了分享！")
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
