//
//  SettingTextViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/25.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SettingTextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var navBar: UINavigationBar?
    fileprivate var doneButton: UIButton?

    var navTitle: String?
    var textString: String?
    
    var stringTextField: UITextField?
    fileprivate var c_user = AVUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        self.view.addSubview(tableView)
        
        //导航栏
        createNavBar()
        
        print(textString!)
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        return 1
    }
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "stringCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        
        stringTextField = UITextField.init(frame: CGRect(x: 16, y: 0, width: self.view.frame.width - 24, height: 50))
        stringTextField?.delegate = self
        stringTextField?.font = UIFont.systemFont(ofSize: 14)
        if navTitle == "签名" {
            if let bio = c_user?.value(forKey: "bio"){
                stringTextField?.text = bio as? String
            }
        }else {
            if let nick_name = c_user?.value(forKey: "nickName"){
                stringTextField?.text = nick_name as? String
            }
        }
        stringTextField?.placeholder = "未填写"
        stringTextField?.tintColor = green
        stringTextField?.returnKeyType = .done
        stringTextField?.clearButtonMode = .whileEditing
        cell?.contentView.addSubview(stringTextField!)
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func updateUserInfo() {
        if stringTextField?.text == textString {
            if navTitle == "签名" {
                Drop.down("签名没有改动！", state: .color(red), duration: 2)
            }else {
                Drop.down("昵称没有改动！", state: .color(red), duration: 2)
            }
        }else {
            let string = stringTextField?.text?.trimmingCharacters(in: .whitespaces)
            if string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
                Drop.down("不能为空！", state: .color(red), duration: 2)
            }else {
                print("点击了完成")
                let reachability = Reachability.init()
                if navTitle == "签名" {
                    if (reachability?.isReachable)! {
                        c_user?.setObject(stringTextField?.text!, forKey: "bio")
                        c_user?.saveInBackground()
                        Drop.down("保存成功！", state: .color(green), duration: 1.4)
                        Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                    }else {
                        Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                    }
                }else {
                    if (reachability?.isReachable)! {
                        c_user?.setObject(stringTextField?.text!, forKey: "nickName")
                        c_user?.saveInBackground()
                        Drop.down("保存成功！", state: .color(green), duration: 1.4)
                        Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                    }else {
                        Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                    }
                }
            }
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(back))
        navigationItem.title = navTitle
        doneButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        doneButton?.setTitle("完成", for: .normal)
        doneButton?.setTitleColor(UIColor.white, for: .normal)
        doneButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        doneButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        doneButton?.addTarget(self, action: #selector(updateUserInfo), for: .touchUpInside)
        let rightBtn = UIBarButtonItem.init(customView: doneButton!)
//        doneButton?.isEnabled = false
        //用于消除右边空隙，要不然按钮顶不到最右
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -7;
        //设置导航项左右边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationItem.setRightBarButtonItems([spacer,rightBtn], animated: true)
        return navigationItem
    }
    
    //返回上一级页面
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
