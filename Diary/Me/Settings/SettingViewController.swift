//
//  SettingViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/10/18.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    var settingNavigationBar: UINavigationBar?
    
    var settingAllCellNames: Dictionary<Int, [String]>?
    
    var settingImgData = [
        ["image0":"warning.png", "image1":"skin.png", "image2":"star.png"],
        ["image0":"locked.png", "image1":"trash.png", "image2":"bubbles.png"],
        ["image2":"info.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        createSettingNavigationBar()
        
        createSettingTableView()
        
                
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(SettingViewController.backToMe))
        navigationItem.title = "设置"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: false)
        return navigationItem
    }
    
    //返回“我的”页面
    func backToMe() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //创建tableView
    func createSettingTableView() {
        self.settingAllCellNames =  [
            0:[String](["账户安全", "密码锁"]),
            1:[String](["主题皮肤", "清除缓存"]),
            2:[String](["给留忆评分", "和我们聊聊留忆", "关于留忆"]),
            3:[String](["退出登录"])
        ]
        //tableView
        let settingTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        settingTableView.separatorColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
//        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.view.addSubview(settingTableView)
        
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
            return 2
        }else if section == 2 {
            return 3
        }else {
            return 1
        }
    }
    
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SettingCellID"
        var settingCell = tableView.dequeueReusableCell(withIdentifier: cellID)
        settingCell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        var data = self.settingAllCellNames?[indexPath.section]
        settingCell?.textLabel?.text = data![indexPath.row]
        
        let rightIcon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon.image = UIImage(named: "arrow_Right")
        settingCell?.accessoryView = rightIcon
        
        let settingItem = settingImgData[indexPath.row]
        if indexPath.section == 0 {
            settingCell?.imageView?.image = UIImage(named: settingItem["image0"]!)
        }
        else if indexPath.section == 1 {
            settingCell?.imageView?.image = UIImage(named: settingItem["image1"]!)
        }
        else if indexPath.section == 2 {
            settingCell?.imageView?.image = UIImage(named: settingItem["image2"]!)
        }
        else {
            settingCell?.textLabel?.text = nil
            let logoutIcon = UIImageView.init(frame: CGRect(x: self.view.frame.width / 2 - 42, y: 12, width: 18, height: 18))
            logoutIcon.image = UIImage(named: "logout")
            settingCell?.addSubview(logoutIcon)
            let logoutLabel = UILabel.init(frame: CGRect(x: self.view.frame.width / 2 - 20, y: 0, width: 80, height: 43.5))
            logoutLabel.text = "退出登录"
            logoutLabel.textColor = #colorLiteral(red: 1, green: 0.2855349779, blue: 0.1690564752, alpha: 1)
            logoutLabel.font = UIFont.boldSystemFont(ofSize: 16)
            settingCell?.accessoryType = .none
            settingCell?.accessoryView = UIView.init()
            settingCell?.addSubview(logoutLabel)
        }
        //修改cell选中的背景色
        settingCell?.selectedBackgroundView = UIView.init()
        settingCell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return settingCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CodedLockView")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        if indexPath.section == 2 {
            if indexPath.row == 2 {
                let viewController = AboutAppViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                logout()
//                let viewController = SettingViewController()
//                viewController.hidesBottomBarWhenPushed = true
//                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //退出登录选择
    func logout() {
        let alertController4 = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "退出登录", style: .destructive, handler: {
                action in
                self.logoutAction()
            })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
                action in
                print("点击了取消！")
            })
        alertController4.addAction(cancelAction)
        alertController4.addAction(okAction)
        self.present(alertController4, animated: true, completion: nil)
    }
    
    //退出登录动作
    func logoutAction() {
        print("点击了确定！")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateInitialViewController()
        viewController?.modalTransitionStyle = .flipHorizontal
        self.present(viewController!, animated: true, completion: nil)
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
