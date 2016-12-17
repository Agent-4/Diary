
//
//  RetrievePasswordViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/14.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class RetrievePasswordViewController: UIViewController, UITextFieldDelegate{
    
    var navBar: UINavigationBar?

    var emailTextField: UITextField?
    var confirmButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createNavBar()
        
        //文本提示
        let label = UILabel.init(frame: CGRect(x: 0, y: 90, width: self.view.frame.width, height: 30))
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        label.textAlignment = .center
        label.text = "请输入你已注册留忆账号的邮箱:"
        self.view.addSubview(label)
        
        //账号邮箱输入框
        emailTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 130, width: 240, height: 36))
        emailTextField?.delegate = self
        emailTextField?.font = UIFont.systemFont(ofSize: 14)
        emailTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        emailTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        emailTextField?.placeholder = "输入邮箱"
        emailTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        emailTextField?.layer.borderWidth = 1
        emailTextField?.layer.masksToBounds = true
        emailTextField?.layer.cornerRadius = 18
        let emailTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        emailTextFieldLeftView.image = UIImage(named: "emailIcon")
        emailTextField?.leftView = emailTextFieldLeftView
        emailTextField?.leftViewMode = .always
        emailTextField?.clearButtonMode = .whileEditing
        emailTextField?.keyboardType = .emailAddress
        emailTextField?.returnKeyType = .done
        self.view.addSubview(emailTextField!)
        
        //确认按钮
        let confirmButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 - 60, y: 190, width: 120, height: 36))
        confirmButton.setTitle("确认", for: .normal)
        confirmButton.setTitle("确认", for: .highlighted)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        confirmButton.backgroundColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        confirmButton.layer.cornerRadius = 18
        confirmButton.layer.masksToBounds = true
//        confirmButton?.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        self.view.addSubview(confirmButton)
        
    }
    //创建导航栏
    func createNavBar() {
        navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar?.isTranslucent = false
        navBar?.barTintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        navBar?.tintColor = UIColor.white
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)]
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.pushItem(makeNavBar(), animated: true)
        self.view.addSubview(navBar!)
    }
    
    //设置导航栏左右按钮、标题
    func makeNavBar() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSignIn))
        navigationItem.title = "找回密码"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    
    //返回“登录”页面
    func backToSignIn() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField?.resignFirstResponder()
        return true
    }
    
    //收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
