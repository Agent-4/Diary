//
//  SignUpViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var navBar: UINavigationBar?
    var countdownTimer: Timer?
    var greenColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var sentCodeButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        signUpButton.layer.cornerRadius = 4
        
        //绘制直线
        let underLine1 = LineView.init(frame: CGRect(x: 59, y: 138, width: view.frame.width - 85, height: 0.5))
        let underLine2 = LineView.init(frame: CGRect(x: 59, y: 190, width: view.frame.width - 85, height: 0.5))
        let underLine3 = LineView.init(frame: CGRect(x: 59, y: 240, width: view.frame.width - 85, height: 0.5))
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
        label2.textColor = greenColor
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
    //点击注册按钮
    @IBAction func signUp(_ sender: Any) {
        print("点击了注册！")
    }
    // 发送短信验证码
    @IBAction func sentVerificationCode(_ sender: Any) {
        isCounting = true
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
    
    //创建导航栏
    func createNavBar() {
        navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar?.isTranslucent = false
        navBar?.barTintColor = greenColor
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
    
    @IBOutlet weak var eyeButton: UIButton!
    var hide = false
    @IBAction func hideOrNot(_ sender: Any) {
        switch hide {
        case true:
            eyeButton.setBackgroundImage(UIImage(named:"see"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            hide = false
        case false:
            eyeButton.setBackgroundImage(UIImage(named:"hide"), for: .normal)
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
        verificationCodeTextField?.resignFirstResponder()
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
