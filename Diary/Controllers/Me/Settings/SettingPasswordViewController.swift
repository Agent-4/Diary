//
//  SettingPasswordViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/23.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SettingPasswordViewController: UIViewController, UITextFieldDelegate{
    
    var navBar: UINavigationBar?
    
    var oldPasswordTextField: UITextField?
    var newPasswordTextField: UITextField?
    var confirmButton: UIButton?
    
    var verificationIcon: UIImageView!
    var passwordIcon: UIImageView!
    
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
        
        passwordIcon = UIImageView.init(frame: CGRect(x: 20, y: 100, width: 18, height: 18))
        passwordIcon.image = UIImage(named: "password")
        self.view.addSubview(passwordIcon)
        verificationIcon = UIImageView.init(frame: CGRect(x: 21, y: 151.5, width: 17, height: 17))
        verificationIcon.image = UIImage(named: "verificationIcon")
        self.view.addSubview(verificationIcon)
        
        oldPasswordTextField = UITextField.init(frame: CGRect(x: 48, y: 94, width: view.frame.width - 64, height: 30))
        oldPasswordTextField?.delegate = self
        oldPasswordTextField?.font = UIFont.systemFont(ofSize: 15)
        oldPasswordTextField?.tintColor = green
        oldPasswordTextField?.placeholder = "输入旧密码"
        oldPasswordTextField?.borderStyle = .none
        oldPasswordTextField?.clearButtonMode = .whileEditing
        oldPasswordTextField?.isSecureTextEntry = true
        oldPasswordTextField?.returnKeyType = .next
        oldPasswordTextField?.tag = 11
        self.view.addSubview(oldPasswordTextField!)
        
        newPasswordTextField = UITextField.init(frame: CGRect(x: 49, y: 145, width: view.frame.width - 64, height: 30))
        newPasswordTextField?.delegate = self
        newPasswordTextField?.font = UIFont.systemFont(ofSize: 15)
        newPasswordTextField?.tintColor = green
        newPasswordTextField?.placeholder = "输入新密码"
        newPasswordTextField?.borderStyle = .none
        newPasswordTextField?.clearButtonMode = .whileEditing
        newPasswordTextField?.isSecureTextEntry = true
        newPasswordTextField?.returnKeyType = .done
        newPasswordTextField?.tag = 12
        self.view.addSubview(newPasswordTextField!)
        
        //确认按钮
        confirmButton = UIButton.init(frame: CGRect(x: 10, y: 205, width: view.frame.width - 20, height: 40))
        confirmButton?.setTitle("修改", for: .normal)
        confirmButton?.setTitle("修改", for: .highlighted)
        confirmButton?.setTitleColor(UIColor.white, for: .normal)
        confirmButton?.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        confirmButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        confirmButton?.py_add(toThemeColorPool: "backgroundColor")
        confirmButton?.layer.cornerRadius = 2
        confirmButton?.layer.masksToBounds = true
        confirmButton?.addTarget(self, action: #selector(userUpdatePassword), for: .touchUpInside)
        self.view.addSubview(confirmButton!)
        
        
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSettings))
        navigationItem.title = "修改密码"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    //返回“设置”页面
    func backToSettings() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //修改密码
    func userUpdatePassword() {
        let reachability = Reachability.init()
        if (reachability?.isReachable)! {
            let user = AVUser.current()
            user?.updatePassword((oldPasswordTextField?.text)!, newPassword: (newPasswordTextField?.text)!, block: {
                (succeeded, error) in
                if (succeeded != nil) {
                    Drop.down("密码修改成功！", state: .color(green), duration: 2)
                    self.confirmButton?.setTitle("修改成功", for: .normal)
                    self.oldPasswordTextField?.text = nil
                    self.newPasswordTextField?.text = nil
                    self.confirmButton?.isEnabled = false
                    user?.isAuthenticated(withSessionToken: (user?.sessionToken)!, callback: {
                        (succeeded, error) in
                        if (succeeded) {
                            // 用户的 sessionToken 有效
                            Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.backToSettings), userInfo: nil, repeats: false)
                        }else {
                            Drop.down("密码修改成功，请重新登录！", state: .color(red), duration: 2)
                            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.backToSettings), userInfo: nil, repeats: false)
                            
                        }
                    })
                }else{
                    let errors = error! as NSError
                    Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                    print(errors)
                }
            })
        }else {
            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
        }
    }
    
    // 重新登录
    func re_signIn() {
        AVUser.logOut()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateInitialViewController()
        vc?.modalTransitionStyle = .flipHorizontal
        self.present(vc!, animated: true, completion: nil)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag == 11 {
            newPasswordTextField?.becomeFirstResponder()
        }else {
            newPasswordTextField?.resignFirstResponder()
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
