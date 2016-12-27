//
//  SignInViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {

    var userEmailTextField: UITextField?
    var userPasswordTextField: UITextField?
    var signInButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmailTextField?.delegate = self
        self.userPasswordTextField?.delegate = self
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        //App图标
        let AppIco = UIImageView.init(frame: CGRect(x: self.view.frame.width/2 - 60, y: 44, width: 120, height: 120))
        AppIco.image = UIImage(named: "memory")
        self.view.addSubview(AppIco)
        
        //账号邮箱输入框
        userEmailTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 170, width: 240, height: 36))
        userEmailTextField?.delegate = self
        userEmailTextField?.tag = 100
        userEmailTextField?.font = UIFont.systemFont(ofSize: 14)
        userEmailTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        userEmailTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        userEmailTextField?.placeholder = "账号邮箱"
        userEmailTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        userEmailTextField?.layer.borderWidth = 1
        userEmailTextField?.layer.masksToBounds = true
        userEmailTextField?.layer.cornerRadius = 18
        let emailTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30,height: 25))
        emailTextFieldLeftView.image = UIImage(named: "userIcon")
        userEmailTextField?.leftView = emailTextFieldLeftView
        userEmailTextField?.leftViewMode = .always
        userEmailTextField?.clearButtonMode = .whileEditing
        userEmailTextField?.keyboardType = .emailAddress
        userEmailTextField?.returnKeyType = .next
        self.view.addSubview(userEmailTextField!)
        
        //密码输入框
        userPasswordTextField = UITextField.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 220, width: 240, height: 36))
        userPasswordTextField?.delegate = self
        userPasswordTextField?.tag = 101
        userPasswordTextField?.font = UIFont.systemFont(ofSize: 14)
        userPasswordTextField?.textColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        userPasswordTextField?.tintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        userPasswordTextField?.placeholder = "密码"
        userPasswordTextField?.layer.borderColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1).cgColor
        userPasswordTextField?.layer.borderWidth = 1
        userPasswordTextField?.layer.masksToBounds = true
        userPasswordTextField?.layer.cornerRadius = 18
        let passwordTextFieldLeftView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        passwordTextFieldLeftView.image = UIImage(named: "passwordIcon")
        userPasswordTextField?.leftView = passwordTextFieldLeftView
        userPasswordTextField?.leftViewMode = .always
        userPasswordTextField?.clearButtonMode = .whileEditing
        userPasswordTextField?.returnKeyType = .go
        userPasswordTextField?.isSecureTextEntry = true
        self.view.addSubview(userPasswordTextField!)
        
        //登录按钮
        signInButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 - 120, y: 272, width: 240, height: 36))
        signInButton?.setTitle("登录", for: .normal)
        signInButton?.setTitle("登录", for: .highlighted)
        signInButton?.setTitleColor(UIColor.white, for: .normal)
        signInButton?.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        signInButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        signInButton?.backgroundColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        signInButton?.layer.cornerRadius = 18
        signInButton?.layer.masksToBounds = true
        signInButton?.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.view.addSubview(signInButton!)
        
        //注册账号按钮
        let registerButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 - 110, y: 312, width: 55, height: 30))
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        registerButton.setTitle("注册账号", for: .normal)
        registerButton.setTitleColor(#colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1), for: .normal)
        registerButton.addTarget(self, action: #selector(goToRegisterViewPage), for: .touchUpInside)
        self.view.addSubview(registerButton)
        
        //忘记密码按钮
        let forgotPasswordButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 + 50, y: 312, width: 58, height: 30))
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        forgotPasswordButton.setTitle("忘记密码?", for: .normal)
        forgotPasswordButton.setTitleColor(#colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1), for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(goToRetrievePasswordViewPage), for: .touchUpInside)
        self.view.addSubview(forgotPasswordButton)
        
        //文本提示
        let label = UILabel.init(frame: CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height - 90, width: 100, height: 20))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.text = "—— 第三方登录 ——"
        self.view.addSubview(label)
        
        //weChat按钮
        let wechatButton = UIButton.init(frame: CGRect(x: self.view.frame.width/3 - 46, y: self.view.frame.height - 60, width: 36, height: 46))
        wechatButton.setImage(UIImage(named: "wechat"), for: .normal)
        wechatButton.setTitle("微信", for: .normal)
        wechatButton.setTitleColor(UIColor.lightGray, for: .normal)
        wechatButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        wechatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 10 , right: 0)
        wechatButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -65, bottom: -36, right: 0)
        self.view.addSubview(wechatButton)
        
        //QQ按钮
        let qqButton = UIButton.init(frame: CGRect(x: self.view.frame.width/2 - 18, y: self.view.frame.height - 60, width: 36, height: 46))
        qqButton.setImage(UIImage(named: "qq"), for: .normal)
        qqButton.setTitle("QQ", for: .normal)
        qqButton.setTitleColor(UIColor.lightGray, for: .normal)
        qqButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        qqButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 10 , right: 0)
        qqButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -65, bottom: -36, right: 0)
        self.view.addSubview(qqButton)
        
        //weibo按钮
        let weiboButton = UIButton.init(frame: CGRect(x: self.view.frame.width/3 * 2 + 10, y: self.view.frame.height - 60, width: 36, height: 46))
        weiboButton.setImage(UIImage(named: "weibo"), for: .normal)
        weiboButton.setTitle("微博", for: .normal)
        weiboButton.setTitleColor(UIColor.lightGray, for: .normal)
        weiboButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        weiboButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 10 , right: 0)
        weiboButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -65, bottom: -36, right: 0)
        self.view.addSubview(weiboButton)
        
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
            case 100:
                userPasswordTextField?.becomeFirstResponder()
            case 101:
                userPasswordTextField?.resignFirstResponder()
            default: break
        }
        return true
    }
    
    //登录按钮动作
    func signIn() {
        print("点击了登录！")
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        mainVC?.modalTransitionStyle = .flipHorizontal
        self.present(mainVC!, animated: true, completion: nil)
    }
    
    //转到注册页面
    func goToRegisterViewPage() {
        let viewController = RegisterViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //转到找回密码页面
    func goToRetrievePasswordViewPage() {
        let viewController = RetrievePasswordViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField?.resignFirstResponder()
        userPasswordTextField?.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
