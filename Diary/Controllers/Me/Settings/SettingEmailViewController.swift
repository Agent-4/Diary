//
//  SettingEmailViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/25.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SettingEmailViewController: UIViewController, UITextFieldDelegate {
    
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    var eyeBtn: UIButton?
    var sentButton: UIButton?
    fileprivate var c_user = AVUser.current()
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        createNavBar()
        
        let view1 = UIView.init(frame: CGRect(x: 10, y: 84, width: view.frame.width - 20, height: 50))
        view1.backgroundColor = UIColor.white
        let view2 = UIView.init(frame: CGRect(x: 10, y: 135, width: view.frame.width - 20, height: 50))
        view2.backgroundColor = UIColor.white
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        
        //账号邮箱输入框
        emailTextField = UITextField.init(frame: CGRect(x: 30, y: 94, width: view.frame.width - 46, height: 30))
        emailTextField?.delegate = self
        emailTextField?.font = UIFont.systemFont(ofSize: 14)
        emailTextField?.tintColor = green
        if let userEmail = c_user?.email {
            emailTextField?.text = userEmail
        }
        emailTextField?.placeholder = "输入邮箱"
        emailTextField?.borderStyle = .none
        emailTextField?.clearButtonMode = .whileEditing
        emailTextField?.keyboardType = .emailAddress
        emailTextField?.returnKeyType = .next
        emailTextField?.tag = 31
        self.view.addSubview(emailTextField!)
        
        passwordTextField = UITextField.init(frame: CGRect(x: 30, y: 145, width: view.frame.width - 80, height: 30))
        passwordTextField?.delegate = self
        passwordTextField?.font = UIFont.systemFont(ofSize: 14)
        passwordTextField?.tintColor = green
        passwordTextField?.placeholder = "输入密码"
        passwordTextField?.borderStyle = .none
        passwordTextField?.clearButtonMode = .whileEditing
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.returnKeyType = .done
        passwordTextField?.tag = 32
        self.view.addSubview(passwordTextField!)
        
        eyeBtn = UIButton.init(frame: CGRect(x: view.frame.width - 45, y: 148, width: 24, height: 24))
        eyeBtn?.setBackgroundImage(UIImage(named: "password_unlook"), for: .normal)
        eyeBtn?.addTarget(self, action: #selector(textEntryChange), for: .touchUpInside)
        self.view.addSubview(eyeBtn!)
        
        //确认按钮
        sentButton = UIButton.init(frame: CGRect(x: 10, y: 205, width: view.frame.width - 20, height: 40))
        sentButton?.setTitle("发送验证邮箱", for: .normal)
        sentButton?.setTitleColor(UIColor.white, for: .normal)
        sentButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        sentButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sentButton?.py_add(toThemeColorPool: "backgroundColor")
        sentButton?.layer.cornerRadius = 2
        sentButton?.layer.masksToBounds = true
        sentButton?.addTarget(self, action: #selector(sentEmail), for: .touchUpInside)
        self.view.addSubview(sentButton!)
    }
    
    //发送验证邮箱
    func sentEmail() {
        AVUser.logInWithUsername(inBackground: (c_user?.username)!, password: (passwordTextField?.text)!, block:  {
            (user, error) in
            if user != nil {
                AVUser.requestEmailVerify((self.emailTextField?.text)!, with: { (succeeded, error) in
                    if (succeeded) {
                        Drop.down("请求重发验证邮件成功！", state: .color(green), duration: 1.5)
                        self.sentButton?.setTitle("已发送", for: .normal)
                        self.passwordTextField?.text = nil
                        self.sentButton?.isEnabled = false
                        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                    }else {
                        let errors = error! as NSError
                        Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        print(errors)
                    }
                })
            }else{
                let errors = error! as NSError
                switch errors.code {
                case -1009:
                    Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                case 210:
                    if self.passwordTextField?.text == "" {
                        Drop.down("密码不能为空！", state: .color(red), duration: 2)
                    }else{Drop.down("密码错误！", state: .color(red), duration: 2)}
                default:
                    Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                }
                print(errors)
            }
        })
    }
    
    var hide = false
    func textEntryChange() {
        switch hide {
            case true:
                eyeBtn?.setBackgroundImage(UIImage(named:"password_unlook"), for: .normal)
                passwordTextField?.isSecureTextEntry = true
                hide = false
            case false:
                eyeBtn?.setBackgroundImage(UIImage(named:"password_look"), for: .normal)
                passwordTextField?.isSecureTextEntry = false
                hide = true
        }
    }
    
    //创建导航栏
    func createNavBar() {
        let navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar.isTranslucent = false
        navBar.py_add(toThemeColorPool: "barTintColor")
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.pushItem(createBarItem(), animated: true)
        self.view.addSubview(navBar)
    }
    //设置导航栏左右按钮、标题
    func createBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(back))
        navigationItem.title = navTitle
        //设置导航项左右边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    
    //返回上一级页面
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
            case 31:
                passwordTextField?.becomeFirstResponder()
            case 32:
                passwordTextField?.resignFirstResponder()
            default: break
        }
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
