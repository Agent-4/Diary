//
//  SignInViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var greenColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        //绘制直线
        let underLine1 = LineView.init(frame: CGRect(x: 59, y: 203, width: view.frame.width - 85, height: 0.5))
        let underLine2 = LineView.init(frame: CGRect(x: 59, y: 253, width: view.frame.width - 85, height: 0.5))
        self.view.addSubview(underLine1)
        self.view.addSubview(underLine2)
        
        signInButton.layer.cornerRadius = 4
        
        //文本提示
        let label = UILabel.init(frame: CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height - 90, width: 100, height: 20))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.text = "—— 第三方登录 ——"
        self.view.addSubview(label)
        
        //weChat按钮
        let wechatButton = UIButton(frame: CGRect(x: self.view.frame.width/3 - 46, y: self.view.frame.height - 60, width: 36, height: 46))
        wechatButton.setImage(UIImage(named: "wechat"), for: .normal)
        wechatButton.setTitle("微信", for: .normal)
        wechatButton.setTitleColor(UIColor.lightGray, for: .normal)
        wechatButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        wechatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 10 , right: 0)
        wechatButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -65, bottom: -36, right: 0)
        self.view.addSubview(wechatButton)
        
        //QQ按钮
        let qqButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 18, y: self.view.frame.height - 60, width: 36, height: 46))
        qqButton.setImage(UIImage(named: "qq"), for: .normal)
        qqButton.setTitle("QQ", for: .normal)
        qqButton.setTitleColor(UIColor.lightGray, for: .normal)
        qqButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        qqButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 10 , right: 0)
        qqButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -65, bottom: -36, right: 0)
        self.view.addSubview(qqButton)
        
        //weibo按钮
        let weiboButton = UIButton(frame: CGRect(x: self.view.frame.width/3 * 2 + 10, y: self.view.frame.height - 60, width: 36, height: 46))
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
            case 10:
                passwordTextField?.becomeFirstResponder()
            case 11:
                signIn(signInButton)
            default: break
        }
        return true
    }
    
    //登录按钮动作
    @IBAction func signIn(_ sender: Any) {
        print("点击了登录！")
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        mainVC?.modalTransitionStyle = .flipHorizontal
        self.present(mainVC!, animated: true, completion: nil)
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
        eyeButton.setBackgroundImage(UIImage(named:"see"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            hide = false
        case false:
            eyeButton.setBackgroundImage(UIImage(named:"hide"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            hide = true
        }
    }
    
    //收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
