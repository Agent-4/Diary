//
//  SettingPhoneViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/25.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SettingPhoneViewController: UIViewController, UITextFieldDelegate {

    var phoneNumberTextField: UITextField?
    var smsCodeTextField: UITextField?
    var sentCodeButton: UIButton?
    var countdownTimer: Timer?
    var passwordTextField: UITextField?
    var eyeBtn: UIButton?
    var doneButton: UIButton?
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
        let view3 = UIView.init(frame: CGRect(x: 10, y: 186, width: view.frame.width - 20, height: 50))
        view3.backgroundColor = UIColor.white
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        
        phoneNumberTextField = UITextField.init(frame: CGRect(x: 30, y: 94, width: view.frame.width - 46, height: 30))
        phoneNumberTextField?.delegate = self
        phoneNumberTextField?.font = UIFont.systemFont(ofSize: 14)
        phoneNumberTextField?.tintColor = green
        if let userPhone = c_user?.mobilePhoneNumber {
            phoneNumberTextField?.text = userPhone
        }
        phoneNumberTextField?.placeholder = "输入手机号码"
        phoneNumberTextField?.borderStyle = .none
        phoneNumberTextField?.clearButtonMode = .whileEditing
        phoneNumberTextField?.keyboardType = .numberPad
        self.view.addSubview(phoneNumberTextField!)
        
        smsCodeTextField = UITextField.init(frame: CGRect(x: 30, y: 145, width: self.view.frame.width - 152, height: 30))
        smsCodeTextField?.delegate = self
        smsCodeTextField?.font = UIFont.systemFont(ofSize: 14)
        smsCodeTextField?.tintColor = green
        smsCodeTextField?.placeholder = "输入验证码"
        smsCodeTextField?.borderStyle = .none
        smsCodeTextField?.clearButtonMode = .whileEditing
        smsCodeTextField?.keyboardType = .numberPad
        self.view.addSubview(smsCodeTextField!)
        
        sentCodeButton = UIButton.init(frame: CGRect(x: self.view.frame.width - 120, y: 145, width: 100, height: 30))
        sentCodeButton?.setTitle("获取验证码", for: .normal)
        sentCodeButton?.setTitleColor(green, for: .normal)
        sentCodeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sentCodeButton?.contentHorizontalAlignment = .right
        sentCodeButton?.addTarget(self, action: #selector(sentVerificationCode(_:)), for: .touchUpInside)
        self.view.addSubview(sentCodeButton!)
        
        passwordTextField = UITextField.init(frame: CGRect(x: 30, y: 196, width: view.frame.width - 80, height: 30))
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
        
        eyeBtn = UIButton.init(frame: CGRect(x: view.frame.width - 45, y: 199, width: 24, height: 24))
        eyeBtn?.setBackgroundImage(UIImage(named: "password_unlook"), for: .normal)
        eyeBtn?.addTarget(self, action: #selector(textEntryChange), for: .touchUpInside)
        self.view.addSubview(eyeBtn!)
        
        //确认按钮
        doneButton = UIButton.init(frame: CGRect(x: 10, y: 256, width: view.frame.width - 20, height: 40))
        doneButton?.setTitle("完成", for: .normal)
        doneButton?.setTitleColor(UIColor.white, for: .normal)
        doneButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        doneButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        doneButton?.py_add(toThemeColorPool: "backgroundColor")
        doneButton?.layer.cornerRadius = 2
        doneButton?.layer.masksToBounds = true
        doneButton?.addTarget(self, action: #selector(updatePhone), for: .touchUpInside)
        self.view.addSubview(doneButton!)
    }
    
    //验证手机
    func updatePhone() {
        
        AVUser.logInWithUsername(inBackground: (c_user?.username)!, password: (passwordTextField?.text)!, block:  {
            (user, error) in
            if user != nil {
                let c_user = AVUser.current()
                c_user?.setValue(self.phoneNumberTextField?.text, forKeyPath: "mobilePhoneNumber")
                c_user?.saveInBackground({ (succeeded, error) in
                    if succeeded {
                        AVUser.verifyMobilePhone((self.smsCodeTextField?.text)!) { (succeeded, error) in
                            if succeeded {
                                Drop.down("手机号码绑定成功！", state: .color(green), duration: 2)
                                self.passwordTextField?.text = nil
                                self.doneButton?.isEnabled = false
                                Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                            }else{
                                let errors = error! as NSError
                                switch errors.code {
                                case 127:
                                    Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                                case 603:
                                    Drop.down("无效的短信验证码！", state: .color(red), duration: 2)
                                default:
                                    Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                                }
                                print(errors)
                            }
                        }
                    }else {
                        let errors = error! as NSError
                        switch errors.code {
                        case 127:
                            Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                        case 214:
                            Drop.down("手机号码已经被注册！", state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                        print(errors)
                    }
                    
                })
                
            }else {
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
            }
        })
    }
    
    func sentVerificationCode(_ sender: Any) {
        AVUser.requestMobilePhoneVerify((phoneNumberTextField?.text)!) { (succeeded, error) in
            if succeeded {
                Drop.down("已发送验证码，请注意查收！", state: .color(green), duration: 2)
                self.isCounting = true
            }else{
                let errors = error! as NSError
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
            sentCodeButton?.setTitle("\(newValue)秒后重新获取", for: .normal)
            if newValue <= 0 {
                sentCodeButton?.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
                sentCodeButton?.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            } else {
                sentCodeButton?.setTitleColor(green, for: .normal)
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            sentCodeButton?.isEnabled = !newValue
        }
    }
    func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
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
        passwordTextField?.resignFirstResponder()
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
