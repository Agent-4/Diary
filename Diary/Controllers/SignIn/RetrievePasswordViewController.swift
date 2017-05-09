
//
//  RetrievePasswordViewController.swift
//  Diary
//
//  Created by moxiaohao on 2016/12/14.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class RetrievePasswordViewController: UIViewController, UITextFieldDelegate{
    
    var navBar: UINavigationBar?
    
    var emailTextField: UITextField?
    var phoneNumberTextField: UITextField?
    var smsCodeTextField: UITextField?
    var newPasswordTextField: UITextField?
    var confirmButton: UIButton?
    var resetPasswordButton: UIButton?
    
    var sentCodeButton: UIButton!
    var otherBtn: UIButton?
    var way = false
    
    var countdownTimer: Timer?
    var emailIcon: UIImageView!
    var verificationIcon: UIImageView!
    var passwordIcon: UIImageView!
    
    var underLine2:UIView!
    var underLine3:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createNavBar()
        
        emailIcon = UIImageView.init(frame: CGRect(x: 28, y: 100, width: 16, height: 16))
        emailIcon.image = UIImage(named: "email")
        self.view.addSubview(emailIcon)
        verificationIcon = UIImageView.init(frame: CGRect(x: 28, y: 152, width: 17, height: 17))
        verificationIcon.image = UIImage(named: "verificationIcon")
        self.view.addSubview(verificationIcon)
        passwordIcon = UIImageView.init(frame: CGRect(x: 27, y: 204, width: 18, height: 18))
        passwordIcon.image = UIImage(named: "password")
        self.view.addSubview(passwordIcon)
        verificationIcon.isHidden = true
        passwordIcon.isHidden = true
        
        //账号邮箱输入框
        emailTextField = UITextField.init(frame: CGRect(x: 60, y: 93, width: view.frame.width - 85, height: 30))
        emailTextField?.delegate = self
        emailTextField?.font = UIFont.systemFont(ofSize: 15)
        emailTextField?.tintColor = green
        emailTextField?.placeholder = "输入邮箱"
        emailTextField?.borderStyle = .none
        emailTextField?.clearButtonMode = .whileEditing
        emailTextField?.keyboardType = .emailAddress
        emailTextField?.returnKeyType = .done
        self.view.addSubview(emailTextField!)
        
        phoneNumberTextField = UITextField.init(frame: CGRect(x: 60, y: 93, width: view.frame.width - 85, height: 30))
        phoneNumberTextField?.delegate = self
        phoneNumberTextField?.font = UIFont.systemFont(ofSize: 15)
        phoneNumberTextField?.tintColor = green
        phoneNumberTextField?.placeholder = "输入手机号码"
        phoneNumberTextField?.borderStyle = .none
        phoneNumberTextField?.clearButtonMode = .whileEditing
        phoneNumberTextField?.keyboardType = .numberPad
        phoneNumberTextField?.returnKeyType = .done
        self.view.addSubview(phoneNumberTextField!)
        phoneNumberTextField?.isHidden = true
        
        smsCodeTextField = UITextField.init(frame: CGRect(x: 60, y: 145, width: self.view.frame.width - 182, height: 30))
        smsCodeTextField?.delegate = self
        smsCodeTextField?.font = UIFont.systemFont(ofSize: 15)
        smsCodeTextField?.tintColor = green
        smsCodeTextField?.placeholder = "输入验证码"
        smsCodeTextField?.borderStyle = .none
        smsCodeTextField?.clearButtonMode = .whileEditing
        smsCodeTextField?.keyboardType = .numberPad
        smsCodeTextField?.returnKeyType = .done
        self.view.addSubview(smsCodeTextField!)
        smsCodeTextField?.isHidden = true
        
        sentCodeButton = UIButton.init(frame: CGRect(x: self.view.frame.width - 124, y: 145, width: 100, height: 30))
        sentCodeButton?.setTitle("获取验证码", for: .normal)
        sentCodeButton?.setTitleColor(green, for: .normal)
        sentCodeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sentCodeButton?.contentHorizontalAlignment = .right
        sentCodeButton?.addTarget(self, action: #selector(sentVerificationCode(_:)), for: .touchUpInside)
        self.view.addSubview(sentCodeButton!)
        sentCodeButton?.isHidden = true
        
        newPasswordTextField = UITextField.init(frame: CGRect(x: 60, y: 197, width: view.frame.width - 85, height: 30))
        newPasswordTextField?.delegate = self
        newPasswordTextField?.font = UIFont.systemFont(ofSize: 15)
        newPasswordTextField?.tintColor = green
        newPasswordTextField?.placeholder = "输入新密码"
        newPasswordTextField?.borderStyle = .none
        newPasswordTextField?.clearButtonMode = .whileEditing
        newPasswordTextField?.isSecureTextEntry = true
        newPasswordTextField?.returnKeyType = .done
        self.view.addSubview(newPasswordTextField!)
        newPasswordTextField?.isHidden = true
        
        //下横线
        let underLine1 = LineView.init(frame: CGRect(x: 25, y: 132, width: view.frame.width - 50, height: 0.5))
        underLine2 = LineView.init(frame: CGRect(x: 25, y: 184, width: view.frame.width - 50, height: 0.5))
        underLine3 = LineView.init(frame: CGRect(x: 25, y: 236, width: view.frame.width - 50, height: 0.5))
        self.view.addSubview(underLine1)
        self.view.addSubview(underLine2)
        self.view.addSubview(underLine3)
        underLine2.isHidden = true
        underLine3.isHidden = true
        
        //确认按钮
        confirmButton = UIButton.init(frame: CGRect(x: 25, y: 162, width: view.frame.width - 50, height: 40))
        confirmButton?.setTitle("确认", for: .normal)
        confirmButton?.setTitle("确认", for: .highlighted)
        confirmButton?.setTitleColor(UIColor.white, for: .normal)
        confirmButton?.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        confirmButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        confirmButton?.backgroundColor = green
        confirmButton?.layer.cornerRadius = 2
        confirmButton?.layer.masksToBounds = true
        confirmButton?.addTarget(self, action: #selector(sentEmail), for: .touchUpInside)
        self.view.addSubview(confirmButton!)
        
        //短信重置密码按钮
        resetPasswordButton = UIButton.init(frame: CGRect(x: 25, y: 268, width: view.frame.width - 50, height: 40))
        resetPasswordButton?.setTitle("重置密码", for: .normal)
        resetPasswordButton?.setTitle("重置密码", for: .highlighted)
        resetPasswordButton?.setTitleColor(UIColor.white, for: .normal)
        resetPasswordButton?.setTitleColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), for: .highlighted)
        resetPasswordButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        resetPasswordButton?.backgroundColor = green
        resetPasswordButton?.layer.cornerRadius = 2
        resetPasswordButton?.layer.masksToBounds = true
        resetPasswordButton?.addTarget(self, action: #selector(sentEmail), for: .touchUpInside)
        self.view.addSubview(resetPasswordButton!)
        resetPasswordButton?.isHidden = true
        
        //other按钮
        otherBtn = UIButton.init(frame: CGRect(x: 26, y: 209, width: 90, height: 33))
        otherBtn?.setTitle("短信重置密码", for: .normal)
        otherBtn?.setTitleColor(UIColor.darkGray, for: .normal)
        otherBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        otherBtn?.titleLabel?.textAlignment = .left
        otherBtn?.addTarget(self, action: #selector(resetPasswordView), for: .touchUpInside)
        self.view.addSubview(otherBtn!)
    }
    //发送重置密码邮寄
    func sentEmail() {
        switch way {
        case true:
            var passwordLength = 0
            passwordLength = (newPasswordTextField?.text?.lengthOfBytes(using: String.Encoding.utf8))!
            if passwordLength == 0 {
                Drop.down("密码不能为空！", state: .color(red), duration: 2)
            }else if (passwordLength <= 5) {
                Drop.down("密码至少为6位！", state: .color(red), duration: 2)
            }else if (passwordLength > 16) {
                Drop.down("密码不能超过16位！", state: .color(red), duration: 2)
            }else {
                AVUser.resetPassword(withSmsCode: (smsCodeTextField?.text)!, newPassword: (newPasswordTextField?.text)!, block: {
                    (succeeded, error) in
                    if succeeded {
                        self.resetPasswordButton?.setTitle("密码重置成功", for: .normal)
                        self.resetPasswordButton?.isEnabled = false
                        let alertController = UIAlertController(title: "", message: "重置密码成功！", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                            (action) in
                            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.backToSignIn), userInfo: nil, repeats: false)
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else {
                        let errors = error! as NSError
                        switch errors.code {
                        case -1009:
                            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                        case 211:
                            Drop.down("找不到手机号对应的用户！", state: .color(red), duration: 2)
                        case 603:
                            Drop.down("无效的短信验证码！", state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                        print(errors)
                    }
                })
            }
        case false:
            AVUser.requestPasswordResetForEmail(inBackground: (emailTextField?.text)!, block: {
                (succeeded, error) in
                if succeeded {
                    self.confirmButton?.setTitle("已发送", for: .normal)
                    self.confirmButton?.isEnabled = false
                    let alertController = UIAlertController(title: "", message: "重置密码邮件已发送，请注意查收进行重置密码！", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                        (action) in
                        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.backToSignIn), userInfo: nil, repeats: false)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else {
                    let errors = error! as NSError
                    switch errors.code {
                    case -1009:
                        Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                    case 125:
                        Drop.down("电子邮箱地址无效！", state: .color(red), duration: 2)
                    case 205:
                        Drop.down("找不到电子邮箱地址对应的用户！", state: .color(red), duration: 2)
                    case 216:
                        Drop.down("未验证的邮箱地址！", state: .color(red), duration: 2)
                    default:
                        Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                    }
                    print(errors)
                }
            })
        }
        
    }
    
    func sentVerificationCode(_ sender: Any) {
        AVOSCloud.requestSmsCode(withPhoneNumber: (phoneNumberTextField?.text)!) { (succeeded, error) in
            if succeeded {
                Drop.down("已发送验证码，请注意查收！", state: .color(green), duration: 2)
                self.isCounting = true
            }else{
                let errors = error! as NSError
                Drop.down("发送失败！", state: .color(red), duration: 2)
                switch errors.code {
                case -1009:
                    Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                case 127:
                    Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                case 212:
                    Drop.down("请输入手机号码！", state: .color(red), duration: 2)
                default:
                    Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                }
                print(errors)
            }
        }
    }
    
    var remainingSeconds: Int = 0 {
        willSet {
            sentCodeButton.setTitle("\(newValue)秒后重新获取", for: .normal)
            if newValue <= 0 {
                sentCodeButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
                sentCodeButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            } else {
                sentCodeButton.setTitleColor(green, for: .normal)
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            sentCodeButton.isEnabled = !newValue
        }
    }
    func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSignIn))
        navigationItem.title = "重置密码"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    //返回“登录”页面
    func backToSignIn() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func resetPasswordView() {
        switch way {
            case true:
                verificationIcon.isHidden = true
                passwordIcon.isHidden = true
                emailIcon.image = UIImage(named: "email")
                underLine2.isHidden = true
                underLine3.isHidden = true
                phoneNumberTextField?.isHidden = true
                smsCodeTextField?.isHidden = true
                sentCodeButton.isHidden = true
                newPasswordTextField?.isHidden = true
                resetPasswordButton?.isHidden = true
                emailTextField?.isHidden = false
                confirmButton?.isHidden = false
                otherBtn?.frame.origin.y = 209
                otherBtn?.setTitle("短信重置密码", for: .normal)
                way = false
            case false:
                verificationIcon.isHidden = false
                passwordIcon.isHidden = false
                emailIcon.image = UIImage(named: "phone")
                underLine2.isHidden = false
                underLine3.isHidden = false
                phoneNumberTextField?.isHidden = false
                smsCodeTextField?.isHidden = false
                sentCodeButton.isHidden = false
                newPasswordTextField?.isHidden = false
                resetPasswordButton?.isHidden = false
                emailTextField?.isHidden = true
                confirmButton?.isHidden = true
                otherBtn?.frame.origin.y = 315
                otherBtn?.setTitle("邮箱重置密码", for: .normal)
                way = true
        }
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField?.resignFirstResponder()
        phoneNumberTextField?.resignFirstResponder()
        smsCodeTextField?.resignFirstResponder()
        newPasswordTextField?.resignFirstResponder()
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
