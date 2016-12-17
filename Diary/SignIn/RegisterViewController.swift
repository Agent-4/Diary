//
//  RegisterViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    var navBar: UINavigationBar?
    var emailTextField: UITextField?
    var nickNameTextField: UITextField?
    var passwordTextField: UITextField?
    var confirmPasswordTextField: UITextField?
    var registerButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createNavBar()
        
        //邮箱输入框
        emailTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 110, width: 240, height: 36))
        emailTextField?.delegate = self
        emailTextField?.tag = 10
        emailTextField?.font = UIFont.systemFont(ofSize: 14)
        emailTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        emailTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        emailTextField?.placeholder = "输入常用邮箱"
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
        emailTextField?.returnKeyType = .next
        self.view.addSubview(emailTextField!)
        
        //昵称输入框
        nickNameTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 160, width: 240, height: 36))
        nickNameTextField?.delegate = self
        nickNameTextField?.tag = 11
        nickNameTextField?.font = UIFont.systemFont(ofSize: 14)
        nickNameTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        nickNameTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        nickNameTextField?.placeholder = "输入昵称"
        nickNameTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        nickNameTextField?.layer.borderWidth = 1
        nickNameTextField?.layer.masksToBounds = true
        nickNameTextField?.layer.cornerRadius = 18
        let nickNameTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        nickNameTextFieldLeftView.image = UIImage(named: "nickNameIcon")
        nickNameTextField?.leftView = nickNameTextFieldLeftView
        nickNameTextField?.leftViewMode = .always
        nickNameTextField?.clearButtonMode = .whileEditing
        nickNameTextField?.returnKeyType = .next
        self.view.addSubview(nickNameTextField!)
        
        //密码输入框
        passwordTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 210, width: 240, height: 36))
        passwordTextField?.delegate = self
        passwordTextField?.tag = 12
        passwordTextField?.font = UIFont.systemFont(ofSize: 14)
        passwordTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        passwordTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        passwordTextField?.placeholder = "输入密码"
        passwordTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        passwordTextField?.layer.borderWidth = 1
        passwordTextField?.layer.masksToBounds = true
        passwordTextField?.layer.cornerRadius = 18
        let passwordTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        passwordTextFieldLeftView.image = UIImage(named: "passwordIcon")
        passwordTextField?.leftView = passwordTextFieldLeftView
        passwordTextField?.leftViewMode = .always
        passwordTextField?.clearButtonMode = .whileEditing
        passwordTextField?.returnKeyType = .next
        passwordTextField?.isSecureTextEntry = true
        self.view.addSubview(passwordTextField!)
        
        //确认密码输入框
        confirmPasswordTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 260, width: 240, height: 36))
        confirmPasswordTextField?.delegate = self
        confirmPasswordTextField?.tag = 13
        confirmPasswordTextField?.font = UIFont.systemFont(ofSize: 14)
        confirmPasswordTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        confirmPasswordTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        confirmPasswordTextField?.placeholder = "确认密码"
        confirmPasswordTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        confirmPasswordTextField?.layer.borderWidth = 1
        confirmPasswordTextField?.layer.masksToBounds = true
        confirmPasswordTextField?.layer.cornerRadius = 18
        let confirmPasswordTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        confirmPasswordTextFieldLeftView.image = UIImage(named: "confirmPasswordIcon")
        confirmPasswordTextField?.leftView = confirmPasswordTextFieldLeftView
        confirmPasswordTextField?.leftViewMode = .always
        confirmPasswordTextField?.clearButtonMode = .whileEditing
        confirmPasswordTextField?.returnKeyType = .go
        confirmPasswordTextField?.isSecureTextEntry = true
        self.view.addSubview(confirmPasswordTextField!)
        
        //注册按钮
        registerButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 312, width: 240, height: 36))
        registerButton?.setTitle("注册", for: .normal)
        registerButton?.setTitle("注册", for: .highlighted)
        registerButton?.setTitleColor(UIColor.white, for: .normal)
        registerButton?.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        registerButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton?.backgroundColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        registerButton?.layer.cornerRadius = 8
        registerButton?.layer.masksToBounds = true
//        registerButton?.addTarget(self, action: #selector(register), for: .touchUpInside)
        self.view.addSubview(registerButton!)
        
        //文本提示
        let label1 = UILabel.init(frame: CGRect(x: self.view.frame.width/2 - 94, y: self.view.frame.height - 25, width: 142, height: 20))
        label1.font = UIFont.systemFont(ofSize: 11)
        label1.textColor = UIColor.lightGray
        label1.textAlignment = .right
        label1.text = "*点击“注册”代表你同意留忆"
        self.view.addSubview(label1)
        
        //用户条款链接
        let label2 = UILabel.init(frame: CGRect(x: self.view.frame.width/2 + 49, y: self.view.frame.height - 25, width: 45, height: 20))
        label2.font = UIFont.systemFont(ofSize: 11)
        label2.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        label2.textAlignment = .left
        label2.text = "用户条款"
        label2.isUserInteractionEnabled = true
        self.view.addSubview(label2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTermsLabel))
        label2.addGestureRecognizer(tap)
        
        //App图标
        let AppIcon = UIImageView.init(frame: CGRect(x: self.view.frame.width/2 - 75, y: self.view.frame.height - 175, width: 150, height: 150))
        AppIcon.image = UIImage(named: "memory")
        self.view.addSubview(AppIcon)
        
    }
    
    //用户条款点击
    func clickTermsLabel(){
        print("点击了用户条款！")
        let viewController = UserTermsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(goBackToSignIn))
        navigationItem.title = "注册账号"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        
        return navigationItem
    }
    
    //返回“登录”页面
    func goBackToSignIn() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case 10:
            nickNameTextField?.becomeFirstResponder()
        case 11:
            passwordTextField?.becomeFirstResponder()
        case 12:
            confirmPasswordTextField?.becomeFirstResponder()
        case 13:
            confirmPasswordTextField?.resignFirstResponder()
        default: break
        }
        return true
    }
    
    //收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        emailTextField?.resignFirstResponder()
        nickNameTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
        confirmPasswordTextField?.resignFirstResponder()
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
