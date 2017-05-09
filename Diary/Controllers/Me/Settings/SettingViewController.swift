//
//  SettingViewController.swift
//  Diary
//
//  Created by moxiaohao on 2016/10/18.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud
import Kingfisher

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var settingNavigationBar: UINavigationBar?
    var settingTableView: UITableView?
    var settingAllCellNames: Dictionary<Int, [String]>?
    
    var settingImgData = [
        ["image0":"warning.png", "image1":"skin.png", "image2":"star.png"],
        ["image0":"locked.png", "image1":"trash.png", "image2":"bubbles.png"],
        ["image2":"info.png"]
    ]
    
    var cacheSize: String = "0 MB"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        createSettingNavigationBar()
        
        createSettingTableView()
        
        DispatchQueue.global().async {
            self.cacheSize = self.caculateCache()
            DispatchQueue.main.async {
                self.settingTableView?.reloadData()
            }
        }
        
    }
    
    //创建导航栏
    func createSettingNavigationBar() {
        settingNavigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        settingNavigationBar?.isTranslucent = false
        settingNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        settingNavigationBar?.tintColor = UIColor.white
        settingNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        settingNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        settingNavigationBar?.shadowImage = UIImage()
        settingNavigationBar?.pushItem(createSettingBarItem(), animated: true)
        self.view.addSubview(settingNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func createSettingBarItem() -> UINavigationItem {
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
            2:[String](["给留忆评分", "意见反馈", "关于留忆"]),
            3:[String](["退出登录"])
        ]
        //tableView
        settingTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        settingTableView?.delegate = self
        settingTableView?.dataSource = self
        settingTableView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        settingTableView?.separatorColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
//        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.view.addSubview(settingTableView!)
        
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 2
        }else if section == 2 {
            return 3
        }else {
            return 1
        }
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
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
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        var data = self.settingAllCellNames?[indexPath.section]
        cell?.textLabel?.text = data![indexPath.row]
        
        let rightIcon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon.image = UIImage(named: "arrow_Right")
        cell?.accessoryView = rightIcon
        
        let settingItem = settingImgData[indexPath.row]
        if indexPath.section == 0 {
            cell?.imageView?.image = UIImage(named: settingItem["image0"]!)
        }
        else if indexPath.section == 1 {
            cell?.imageView?.image = UIImage(named: settingItem["image1"]!)
            if indexPath.row == 1 {
                cell?.accessoryView = nil
                cell?.detailTextLabel?.text = cacheSize
            }
        }
        else if indexPath.section == 2 {
            cell?.imageView?.image = UIImage(named: settingItem["image2"]!)
        }
        else {
            cell?.textLabel?.text = nil
            let logoutIcon = UIImageView.init(frame: CGRect(x: self.view.frame.width / 2 - 42, y: 15, width: 18, height: 18))
            logoutIcon.image = UIImage(named: "logout")
            cell?.addSubview(logoutIcon)
            let logoutLabel = UILabel.init(frame: CGRect(x: self.view.frame.width / 2 - 20, y: 3, width: 80, height: 44))
            logoutLabel.text = "退出登录"
            logoutLabel.textColor = red
            logoutLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell?.accessoryType = .none
            cell?.accessoryView = UIView.init()
            cell?.addSubview(logoutLabel)
        }
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = SettingAccountViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "CodedLockView")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = SettingSkinViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                //清除缓存
                if clearCache() {
                    AVFile.clearAllCachedFiles()
                    let cache = KingfisherManager.shared.cache
                    cache.clearDiskCache()
                    Drop.down("缓存清除完毕！", state: .color(green), duration: 2)
                    cacheSize = caculateCache()
                    settingTableView?.reloadData()
                }
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
                case 0:
                    break
                case 1:
                    let vc = FeedbackViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case 2:
                    let vc = AboutAppViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                default: break
            }
        }else {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "退出登录", style: .destructive, handler: { (action) in
                    self.logoutAction()
                })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                    print("点击了取消！")
                })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //计算缓存大小
    func caculateCache() -> String {
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,
                                                           FileManager.SearchPathDomainMask.userDomainMask,true).first
        let fileManager = FileManager.default
        var total:Float = 0
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            if childrenPath != nil{
                for path in childrenPath!{
                    let childPath = basePath?.appending("/").appending(path)
                    do{
                        let attr = try fileManager.attributesOfItem(atPath: childPath!)
                        let fileSize = attr[FileAttributeKey.size] as! Float
                        total += fileSize
                    } catch _ { }
                }
            }
        }
        let cacheSize = NSString(format: "%.1f MB", total / 1024.0 / 1024.0 ) as String
        return cacheSize
    }
    
    //清除缓存
    func clearCache() -> Bool {
        var result = true
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            for childPath in childrenPath!{
                let cachePath = basePath?.appending("/").appending(childPath)
                do{  
                    try fileManager.removeItem(atPath: cachePath!)
                    if childPath == childrenPath?.last {
                        result = true
                    }
                } catch _ {
                    result = false
                    if childPath == childrenPath?.last {
                        result = true
                    }
                }
            }
        }
        return result
    }
    
    //退出登录动作
    func logoutAction() {
        print("点击了确定！")
        AVUser.logOut()
        UserDefaults.standard.removeObject(forKey: "theCodedLockPWD")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateInitialViewController()
        vc?.modalTransitionStyle = .flipHorizontal
        self.present(vc!, animated: true, completion: nil)
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
