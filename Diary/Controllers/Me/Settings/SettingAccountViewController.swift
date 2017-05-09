//
//  SettingAccountViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/23.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SettingAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var navBar:UINavigationBar?
    var userAvatar:UIImageView!
    var gender:String = ""
    var tableView:UITableView!
    fileprivate var c_user = AVUser.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        self.view.addSubview(tableView)
        
        //导航栏
        createNavBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
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
        return 0.5
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "profileCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        
        let rightIcon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon.image = UIImage(named: "arrow_Right")
        cell?.accessoryView = rightIcon
        switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell?.textLabel?.text = "邮箱"
                if var eamil:String = c_user?.email {
                    if ((c_user?.value(forKey: "emailVerified")) as! Bool) {
                        cell?.detailTextLabel?.text = eamil
                    }else {
                        eamil.append("(未验证)")
                        cell?.detailTextLabel?.text = eamil
                    }
                }else {
                    cell?.detailTextLabel?.text = "未绑定"
                }
                
            }else{
                cell?.textLabel?.text = "手机"
                if let phone = c_user?.mobilePhoneNumber {
                    cell?.detailTextLabel?.text = phone
                }else {
                    cell?.detailTextLabel?.text = "未绑定"
                }
            }
        case 1:
            cell?.textLabel?.text = "修改密码"
        default:
            break
        }
        cell?.detailTextLabel?.textColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        switch (indexPath.section) {
        case 0:
            if indexPath.row == 0 {
                let vc = SettingEmailViewController()
                vc.navTitle = cell?.textLabel?.text
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let vc = SettingPhoneViewController()
                vc.navTitle = cell?.textLabel?.text
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            let vc = SettingPasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    //创建导航栏
    func createNavBar() {
        navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar?.isTranslucent = false
        navBar?.py_add(toThemeColorPool: "barTintColor")
        navBar?.tintColor = UIColor.white
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.pushItem(createBarItem(), animated: true)
        self.view.addSubview(navBar!)
    }
    //设置导航栏左右按钮、标题
    func createBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSetting))
        navigationItem.title = "账号安全"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    //返回“设置”页面
    func backToSetting() {
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
