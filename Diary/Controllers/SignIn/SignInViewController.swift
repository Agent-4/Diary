//
//  SignInViewController.swift
//  Diary
//
//  Created by moxiaohao on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SignInViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var sentCodeButton: UIButton!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var signInChangedButton: UIButton!
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    var countdownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        navBar?.py_add(toThemeColorPool: "barTintColor")
        fillView?.py_add(toThemeColorPool: "backgroundColor")
        UserThemeColor.setColor()
        
        countdownLabel.isHidden = true
        sentCodeButton.setTitle("获取验证码", for: .normal)
        sentCodeButton.isHidden = true
        phoneNumberTextField.placeholder = "手机号码"
        codeTextField.placeholder = "验证码"
        phoneNumberTextField.isHidden = true
        codeTextField.isHidden = true
        //绘制直线
        let underLine1 = LineView.init(frame: CGRect(x: 25, y: 196, width: view.frame.width - 50, height: 0.5))
        let underLine2 = LineView.init(frame: CGRect(x: 25, y: 247, width: view.frame.width - 50, height: 0.5))
        self.view.addSubview(underLine1)
        self.view.addSubview(underLine2)
        
        signInButton.layer.cornerRadius = 2
        
        
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
            case 10:
                passwordTextField?.becomeFirstResponder()
            case 11:
                signIn(signInButton)
            default: break
        }
        return true
    }
    //登录方式选择
    var theSignInWay = 1
    @IBAction func theSignInWayChanged(_ sender: Any) {
        switch theSignInWay {
            case 0:
                signInChangedButton.setTitle("短信登录", for: .normal)
                userTextField.isHidden = false
                eyeButton.isHidden = false
                passwordTextField.isHidden = false
                countdownLabel.isHidden = true
                sentCodeButton.isHidden = true
                phoneNumberTextField.isHidden = true
                codeTextField.isHidden = true
                userIcon.image = UIImage(named:"user")
                passwordIcon.image = UIImage(named:"password")
                theSignInWay = 1
            case 1:
                signInChangedButton.setTitle("密码登录", for: .normal)
                userTextField.isHidden = true
                eyeButton.isHidden = true
                passwordTextField.isHidden = true
                countdownLabel.isHidden = false
                sentCodeButton.isHidden = false
                phoneNumberTextField.isHidden = false
                codeTextField.isHidden = false
                userIcon.image = UIImage(named:"phone")
                passwordIcon.image = UIImage(named:"verificationIcon")
                theSignInWay = 0
            default:
                break;
        }
    }
    
    @IBAction func sentSMSCode(_ sender: Any) {
        // 发送失败可以查看 error 里面提供的信息
        AVUser.requestLoginSmsCode(phoneNumberTextField.text!) { (succeeded, error) in
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
    
    //登录按钮动作
    @IBAction func signIn(_ sender: Any) {
        switch theSignInWay {
        case 0:
            AVUser.logInWithMobilePhoneNumber(inBackground: phoneNumberTextField.text!, smsCode: codeTextField.text!, block: {
                (user, error) in
                if error == nil {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                    mainVC?.modalTransitionStyle = .flipHorizontal
                    self.present(mainVC!, animated: true, completion: nil)
                }else{
                    let errors = error! as NSError
                    switch errors.code {
                    case -1009:
                        Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                    case 127:
                        Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                    case 211:
                        Drop.down("此手机号码未注册！", state: .color(red), duration: 2)
                    case 603:
                        Drop.down("无效的短信验证码！", state: .color(red), duration: 2)
                    default:
                        Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                    }
                }
            })
        case 1:
            if isPhoneNumber(phoneNumber: userTextField.text!) {
                print("手机号码登录")
                AVUser.logInWithMobilePhoneNumber(inBackground: userTextField.text!, password: passwordTextField.text!, block: {
                    (user, error) in
                    if user != nil {
                        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                        mainVC?.modalTransitionStyle = .flipHorizontal
                        self.present(mainVC!, animated: true, completion: nil)
                    }else{
                        let errors = error! as NSError //error转化,读取code
                        switch errors.code {
                        case -1009:
                            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                        case 127:
                            Drop.down("无效的手机号码！", state: .color(red), duration: 2)
                        case 210:
                            if self.passwordTextField.text == "" {
                                Drop.down("密码不能为空！", state: .color(red), duration: 2)
                            }else{Drop.down("密码错误！", state: .color(red), duration: 2)}
                        case 211:
                            if self.userTextField.text == "" {
                                Drop.down("用户名不能为空！", state: .color(red), duration: 2)
                            }
                            else{Drop.down("用户名不存在！", state: .color(red), duration: 2)}
                        case 219:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                    }
                })
                
            }else {
                print("用户名登录")
                AVUser.logInWithUsername(inBackground: userTextField.text!, password: passwordTextField.text!, block: {
                    (user, error) in
                    if user != nil {
                        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                        mainVC?.modalTransitionStyle = .flipHorizontal
                        self.present(mainVC!, animated: true, completion: nil)
                    }else{
                        let errors = error! as NSError //error转化,读取code
                        switch errors.code {
                        case -1009:
                            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                        case 210:
                            if self.passwordTextField.text == "" {
                                Drop.down("密码不能为空！", state: .color(red), duration: 2)
                            }else{Drop.down("密码错误！", state: .color(red), duration: 2)}
                        case 211:
                            if self.userTextField.text == "" {
                                Drop.down("用户名不能为空！", state: .color(red), duration: 2)
                            }
                            else{Drop.down("用户名不存在！", state: .color(red), duration: 2)}
                        case 219:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        default:
                            Drop.down(errors.localizedDescription, state: .color(red), duration: 2)
                        }
                    }
                })
            }
        default: break
        }
        
    }
    
    //手机号码验证
    func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.characters.count == 0 { return false }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true { return true }
        else { return false }
    }

    //转到找回密码页面
    @IBAction func goToRetrievePasswordViewPage(_ sender: Any) {
        let viewController = RetrievePasswordViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBOutlet weak var eyeButton: UIButton!
    var hide = false
    @IBAction func nputHideOrNot(_ sender: Any) {
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
    
    //收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        codeTextField.resignFirstResponder()
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
