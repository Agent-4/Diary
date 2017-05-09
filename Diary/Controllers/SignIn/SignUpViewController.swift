//
//  SignUpViewController.swift
//  Diary
//
//  Created by moxiaohao on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SignUpViewController: UIViewController {
    
    var navBar: UINavigationBar?
    var countdownTimer: Timer?
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var sentCodeButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var verificationIcon: UIImageView!
    @IBOutlet weak var selectSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        signUpButton.layer.cornerRadius = 2
        
        userNameTextField.isHidden = true
        emailTextField.isHidden = true
        
        //绘制直线
        let underLine1 = LineView.init(frame: CGRect(x: 25, y: 176, width: view.frame.width - 50, height: 0.5))
        let underLine2 = LineView.init(frame: CGRect(x: 25, y: 228, width: view.frame.width - 50, height: 0.5))
        let underLine3 = LineView.init(frame: CGRect(x: 25, y: 280, width: view.frame.width - 50, height: 0.5))
        self.view.addSubview(underLine1)
        self.view.addSubview(underLine2)
        self.view.addSubview(underLine3)
        
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
        label2.textColor = green
        label2.textAlignment = .left
        label2.text = "用户条款"
        label2.isUserInteractionEnabled = true
        self.view.addSubview(label2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTermsLabel))
        label2.addGestureRecognizer(tap)
        
        //App图标
        let AppIcon = UIImageView.init(frame: CGRect(x: self.view.frame.width/2 - 60, y: self.view.frame.height - 143, width: 120, height: 120))
        AppIcon.image = UIImage(named: "memory")
        self.view.addSubview(AppIcon)
        
    }
    //点击注册按钮
    @IBAction func signUp(_ sender: Any) {
        var passwordLength = 0
        let string = passwordTextField?.text?.trimmingCharacters(in: .whitespaces)
        switch theSignUpWay {
        case true:
            passwordLength = (passwordTextField?.text?.lengthOfBytes(using: String.Encoding.utf8))!
            if passwordLength == 0 {
                Drop.down("密码不能为空！", state: .color(red), duration: 2)
            }else if string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
                Drop.down("密码不能全为空格！", state: .color(red), duration: 2)
            }else if (passwordLength <= 5) {
                Drop.down("密码至少为6位！", state: .color(red), duration: 2)
            }else if (passwordLength > 16) {
                Drop.down("密码不能超过16位！", state: .color(red), duration: 2)
            }else {
                AVUser.signUpOrLoginWithMobilePhoneNumber(inBackground: phoneNumberTextField.text!, smsCode: verificationCodeTextField.text!) {
                    (user, error) in
                    if error == nil {
                        let currentUser = AVUser.current()
                        currentUser?.setObject(self.passwordTextField.text, forKey: "password")
                        currentUser?.saveInBackground({ (succeeded, error) in
                            if succeeded {
                                Drop.down("注册成功！", state: .color(green), duration: 2)
                                self.navigationController?.popViewController(animated: true)
                            }else{
                                let errors = error! as NSError
                                print(errors)
                            }
                        })
                    }else{
                        let errors = error! as NSError
                        switch errors.code {
                        case -1009:
                            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                        case 127:
                            Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                        case 214:
                            Drop.down("手机号码已经被注册！", state: .color(red), duration: 2)
                        case 603:
                            Drop.down("无效的短信验证码！", state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                    }
                }
            }
        case false:
            passwordLength = (passwordTextField?.text?.lengthOfBytes(using: String.Encoding.utf8))!
            if passwordLength == 0 {
                Drop.down("密码不能为空！", state: .color(red), duration: 2)
            }else if string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
                Drop.down("密码不能全为空格！", state: .color(red), duration: 2)
            }else if (passwordLength <= 5) {
                Drop.down("密码至少为6位！", state: .color(red), duration: 2)
            }else if (passwordLength > 16) {
                Drop.down("密码不能超过16位！", state: .color(red), duration: 2)
            }else {
                let user = AVUser()
                user.username = userNameTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                user.signUpInBackground({ (succeeded, error) in
                    if succeeded {
                        Drop.down("注册成功，去登录吧！", state: .color(green), duration: 2)
                        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.goBackToSignIn), userInfo: nil, repeats: false)
                    }else{
                        let errors = error! as NSError //error转化
                        switch errors.code {
                        case -1009:
                            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                        case 125:
                            Drop.down("邮箱为空或格式错误！", state: .color(red), duration: 2)
                        case 202:
                            Drop.down("用户名已存在，请换一个！", state: .color(red), duration: 2)
                        case 203:
                            Drop.down("此电子邮箱已经被占用！", state: .color(red), duration: 2)
                        case 217:
                            Drop.down("请输入用户名！", state: .color(red), duration: 2)
                        case 218:
                            Drop.down("请输入密码！", state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                    }
                })
            }
        }
    }
    
    // 发送短信验证码
    @IBAction func sentVerificationCode(_ sender: Any) {
        // 发送失败可以查看 error 里面提供的信息
        AVOSCloud.requestSmsCode(withPhoneNumber: phoneNumberTextField.text!) { (succeeded, error) in
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
            sentCodeButton.setTitle("", for: .normal)
            countdownLabel.text = "\(newValue)秒后重新获取"
            if newValue <= 0 {
                sentCodeButton.setTitle("重新获取验证码", for: .normal)
                countdownLabel.text = ""
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
                countdownLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            sentCodeButton.isEnabled = !newValue
        }
    }
    func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
    var theSignUpWay = true
    @IBAction func indexChange(_ sender: Any) {
        switch selectSegment.selectedSegmentIndex {
            case 0:
                userNameTextField.isHidden = true
                emailTextField.isHidden = true
                verificationCodeTextField.isHidden = false
                countdownLabel.isHidden = false
                sentCodeButton.isHidden = false
                phoneNumberTextField.isHidden = false
                phoneIcon.image = UIImage(named:"phone")
                phoneIcon.frame = CGRect(x: 27, y: 145, width: 18, height: 18)
                verificationIcon.image = UIImage(named:"verificationIcon")
                theSignUpWay = true
            case 1:
                userNameTextField.placeholder = "用户名（注册后不可更改）"
                emailTextField.placeholder = "邮箱"
                userNameTextField.isHidden = false
                emailTextField.isHidden = false
                verificationCodeTextField.isHidden = true
                countdownLabel.isHidden = true
                sentCodeButton.isHidden = true
                phoneNumberTextField.isHidden = true
                phoneIcon.image = UIImage(named:"user")
                phoneIcon.frame = CGRect(x: 26, y: 145, width: 19, height: 19)
                verificationIcon.image = UIImage(named:"email")
                theSignUpWay = false
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
    
    @IBOutlet weak var eyeButton: UIButton!
    var hide = false
    @IBAction func hideOrNot(_ sender: Any) {
        switch hide {
            case true:
                eyeButton.setBackgroundImage(UIImage(named:"password_unlook"), for: .normal)
                passwordTextField.isSecureTextEntry = true
                hide = false
            case false:
                eyeButton.setBackgroundImage(UIImage(named:"password_look"), for: .normal)
                passwordTextField.isSecureTextEntry = false
                hide = true
        }
    }
    
    //用户条款点击
    func clickTermsLabel(){
        print("点击了用户条款！")
        let viewController = TermsOfUserViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //键盘动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
            case 22:
                signUp(signUpButton)
            default: break
        }
        return true
    }
    
    //收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        phoneNumberTextField?.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        verificationCodeTextField?.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
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
