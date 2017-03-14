//
//  AppLockViewController.swift
//  Mo
//
//  Created by 莫晓豪 on 2016/12/31.
//  Copyright © 2016年 莫晓豪. All rights reserved.
//

import UIKit

class AppLockViewController: UIViewController {
    
    var SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    var SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    @IBOutlet weak var AppLockViewNavBar: UINavigationBar!
    
    var view_round1: UIView!
    var view_round2: UIView!
    var view_round3: UIView!
    var view_round4: UIView!
    
    var messageAlert: UILabel!
    
    var truePWD: NSString!
    var PWDFull: NSString!
    var inputPWD: NSString!
    
    var getArray: NSMutableArray!
    
    var number: Int!

    @IBOutlet weak var forgotPWD: UIBarButtonItem!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    
    var greenColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
    var greenBackgroundColor = UIColor(red: 58/255, green: 187/255, blue: 127/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        //去除导航栏底部黑线
        AppLockViewNavBar?.setBackgroundImage(UIImage(), for: .default)
        AppLockViewNavBar?.shadowImage = UIImage()
        
        getArray = NSMutableArray.init(capacity: 0)
        
        // 假的输入圆环点
        view_round1 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*4 - 7, y: 150, width: 14, height: 14))
        view_round1.layer.borderColor = greenColor.cgColor
        view_round1.layer.borderWidth = 1.5
        view_round1.layer.cornerRadius = 7
        view_round1.layer.masksToBounds = true
        self.view.addSubview(view_round1)
        
        view_round2 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*5 - 7, y: 150, width: 14, height: 14))
        view_round2.layer.borderColor = greenColor.cgColor
        view_round2.layer.borderWidth = 1.5
        view_round2.layer.cornerRadius = 7
        view_round2.layer.masksToBounds = true
        self.view.addSubview(view_round2)
        
        view_round3 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*6 - 7, y: 150, width: 14, height: 14))
        view_round3.layer.borderColor = greenColor.cgColor
        view_round3.layer.borderWidth = 1.5
        view_round3.layer.cornerRadius = 7
        view_round3.layer.masksToBounds = true
        self.view.addSubview(view_round3)
        
        view_round4 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*7 - 7, y: 150, width: 14, height: 14))
        view_round4.layer.borderColor = greenColor.cgColor
        view_round4.layer.borderWidth = 1.5
        view_round4.layer.cornerRadius = 7
        view_round4.layer.masksToBounds = true
        self.view.addSubview(view_round4)
        
        //忘记密码按钮先不可用
        forgotPWD.isEnabled = false
        forgotPWD.title = ""
        
        //数字按钮大小及其位置自适应
        number0.frame = CGRect(x: SCREEN_WIDTH/2 - 25, y: SCREEN_HEIGHT - 65, width: 50, height: 50)
        number0.layer.cornerRadius = 25
        number1.frame = CGRect(x: SCREEN_WIDTH/4 - 37.5, y: SCREEN_HEIGHT - 247, width: 50, height: 50)
        number1.layer.cornerRadius = 25
        number2.frame = CGRect(x: SCREEN_WIDTH/2 - 25, y: SCREEN_HEIGHT - 247, width: 50, height: 50)
        number2.layer.cornerRadius = 25
        number3.frame = CGRect(x: (SCREEN_WIDTH/4)*3 - 12.5, y: SCREEN_HEIGHT - 247, width: 50, height: 50)
        number3.layer.cornerRadius = 25
        number4.frame = CGRect(x: SCREEN_WIDTH/4 - 37.5, y: SCREEN_HEIGHT - 185, width: 50, height: 50)
        number4.layer.cornerRadius = 25
        number5.frame = CGRect(x: SCREEN_WIDTH/2 - 25, y: SCREEN_HEIGHT - 185, width: 50, height: 50)
        number5.layer.cornerRadius = 25
        number6.frame = CGRect(x: (SCREEN_WIDTH/4)*3 - 12.5, y: SCREEN_HEIGHT - 185, width: 50, height: 50)
        number6.layer.cornerRadius = 25
        number7.frame = CGRect(x: SCREEN_WIDTH/4 - 37.5, y: SCREEN_HEIGHT - 125, width: 50, height: 50)
        number7.layer.cornerRadius = 25
        number8.frame = CGRect(x: SCREEN_WIDTH/2 - 25, y: SCREEN_HEIGHT - 125, width: 50, height: 50)
        number8.layer.cornerRadius = 25
        number9.frame = CGRect(x: (SCREEN_WIDTH/4)*3 - 12.5, y: SCREEN_HEIGHT - 125, width: 50, height: 50)
        number9.layer.cornerRadius = 25
        delBtn.frame = CGRect(x: (SCREEN_WIDTH/4)*3 - 13, y: SCREEN_HEIGHT - 65, width: 50, height: 50)
        delBtn.layer.cornerRadius = 25
        
        //数字按钮添加动作
        number0.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number1.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number2.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number3.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number4.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number5.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number6.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number7.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number8.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        number9.addTarget(self, action: #selector(numberBtnClick), for: .touchUpInside)
        delBtn.addTarget(self, action: #selector(delBtnClick), for: .touchUpInside)
        
    }
    @IBAction func forgotPWDBtnClick(_ sender: UIBarButtonItem) {
        print("忘记了密码！")
        let passwordLogin = UIAlertController(title: "使用‘账号密码’登录", message: "登录成功后将密码锁关闭或重新设置！", preferredStyle: .alert)
        passwordLogin.addTextField(configurationHandler: {
            (textField: UITextField!) -> Void in
            textField.placeholder = "账号密码"
            textField.isSecureTextEntry = true
        })
        print("账号密码: " + (UserDefaults.standard.string(forKey: "userPassword")! as String))
        let okAction = UIAlertAction(title: "登录", style: .destructive, handler: {
            action in
            let inputUserPassword = passwordLogin.textFields?.first?.text
            if (inputUserPassword == UserDefaults.standard.string(forKey: "userPassword")) {
                let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                let viewController = mainStoryboard.instantiateInitialViewController()
                viewController?.modalTransitionStyle = .flipHorizontal
                self.present(viewController!, animated: true, completion:nil)
            } else {
                print("密码错误！")
                Drop.down("账号密码错误!", state: .color(#colorLiteral(red: 1, green: 0.3722903728, blue: 0.3634029031, alpha: 1)), duration: 2)
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        passwordLogin.addAction(okAction)
        passwordLogin.addAction(cancelAction)
        self.present(passwordLogin, animated: true, completion: nil)
        
    }
    //数字按钮点击响应事件
    func numberBtnClick(tagCount: UIButton) {
        number = tagCount.tag
        PWDFull = NSString.localizedStringWithFormat("%d", number)
        getArray.add(PWDFull)
        inputPWD = NSString.localizedStringWithFormat("%@", getArray)
        
        let savePWD = UserDefaults.standard
        truePWD = savePWD.string(forKey: "theCodedLockPWD") as NSString!
        
        print("输入密码:\n" + (inputPWD! as String))
        
        //圆点显示判断
        if (view_round1.backgroundColor == nil) {
            view_round1.backgroundColor = greenColor
        }
        else if (view_round2.backgroundColor == nil) {
            view_round1.backgroundColor = greenColor
            view_round2.backgroundColor = greenColor
        }
        else if (view_round3.backgroundColor == nil) {
            view_round1.backgroundColor = greenColor
            view_round2.backgroundColor = greenColor
            view_round3.backgroundColor = greenColor
        }
        else if (view_round4.backgroundColor == nil) {
            view_round1.backgroundColor = greenColor
            view_round2.backgroundColor = greenColor
            view_round3.backgroundColor = greenColor
            view_round4.backgroundColor = greenColor
        }
        
        switch tagCount.tag {
            case 0: number0.backgroundColor = greenBackgroundColor
            case 1: number1.backgroundColor = greenBackgroundColor
            case 2: number2.backgroundColor = greenBackgroundColor
            case 3: number3.backgroundColor = greenBackgroundColor
            case 4: number4.backgroundColor = greenBackgroundColor
            case 5: number5.backgroundColor = greenBackgroundColor
            case 6: number6.backgroundColor = greenBackgroundColor
            case 7: number7.backgroundColor = greenBackgroundColor
            case 8: number8.backgroundColor = greenBackgroundColor
            case 9: number9.backgroundColor = greenBackgroundColor
            default: break
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowUserInteraction],
                       animations: {
                            switch tagCount.tag {
                                case 0: self.number0.backgroundColor = nil
                                case 1: self.number1.backgroundColor = nil
                                case 2: self.number2.backgroundColor = nil
                                case 3: self.number3.backgroundColor = nil
                                case 4: self.number4.backgroundColor = nil
                                case 5: self.number5.backgroundColor = nil
                                case 6: self.number6.backgroundColor = nil
                                case 7: self.number7.backgroundColor = nil
                                case 8: self.number8.backgroundColor = nil
                                case 9: self.number9.backgroundColor = nil
                                default: break
                            }
                        }, completion: nil)

        //  判断结构  判断两个字符串是否相等
        if (inputPWD .isEqual(truePWD) && getArray.count == 4) {
            showMessage(message: "密码正确!", backgroundColor: greenColor, delayTime: 2)
            print("密码正确！")
            self.getArray.removeAllObjects()
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let viewController = mainStoryboard.instantiateInitialViewController()
            viewController?.modalTransitionStyle = .flipHorizontal
            self.present(viewController!, animated: true, completion:nil)
            
        }
        else if !(inputPWD .isEqual(truePWD)) && getArray.count == 4 {
            getArray.removeAllObjects()
            forgotPWD.isEnabled = true
            forgotPWD.title = "?"
            print("错误！")
            print("密码是:\n" + savePWD.string(forKey: "theCodedLockPWD")! as String)

            showMessage(message: "密码错误!", backgroundColor: #colorLiteral(red: 1, green: 0.3722903728, blue: 0.3634029031, alpha: 1), delayTime: 2)
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.1)
            UIView.setAnimationRepeatCount(0.8)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDidStop(#selector(dotAnimation1))
            
            view_round1.removeFromSuperview()
            view_round2.removeFromSuperview()
            view_round3.removeFromSuperview()
            view_round4.removeFromSuperview()
            
            view_round1 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*4 - 17, y: 150, width: 14, height: 14))
            view_round1.layer.borderColor = greenColor.cgColor
            view_round1.backgroundColor = greenColor
            view_round1.layer.borderWidth = 1.5
            view_round1.layer.cornerRadius = 7
            view_round1.layer.masksToBounds = true
            self.view.addSubview(view_round1)
            view_round2 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*5 - 17, y: 150, width: 14, height: 14))
            view_round2.layer.borderColor = greenColor.cgColor
            view_round2.backgroundColor = greenColor
            view_round2.layer.borderWidth = 1.5
            view_round2.layer.cornerRadius = 7
            view_round2.layer.masksToBounds = true
            self.view.addSubview(view_round2)
            view_round3 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*6 - 17, y: 150, width: 14, height: 14))
            view_round3.layer.borderColor = greenColor.cgColor
            view_round3.backgroundColor = greenColor
            view_round3.layer.borderWidth = 1.5
            view_round3.layer.cornerRadius = 7
            view_round3.layer.masksToBounds = true
            self.view.addSubview(view_round3)
            view_round4 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*7 - 17, y: 150, width: 14, height: 14))
            view_round4.layer.borderColor = greenColor.cgColor
            view_round4.backgroundColor = greenColor
            view_round4.layer.borderWidth = 1.5
            view_round4.layer.cornerRadius = 7
            view_round4.layer.masksToBounds = true
            self.view.addSubview(view_round4)
            UIView.commitAnimations()
        }
    }
    //删除按钮响应事件
    func delBtnClick() {
        view_round1.backgroundColor = nil
        view_round2.backgroundColor = nil
        view_round3.backgroundColor = nil
        view_round4.backgroundColor = nil
        delBtn.backgroundColor = UIColor.init(red: 255/255, green: 69/255, blue: 75/255, alpha: 0.3)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowUserInteraction],
                       animations: { self.delBtn.backgroundColor = nil }, completion: nil)
        getArray.removeAllObjects()
    }
    //信息提示条
    func showMessage(message: NSString, backgroundColor: UIColor, delayTime: TimeInterval) {
        messageAlert = UILabel.init(frame: CGRect(x: SCREEN_WIDTH/2 - 50, y: 210, width: 100, height: 30))
        messageAlert.layer.cornerRadius = 4
        messageAlert.layer.masksToBounds = true
        messageAlert.backgroundColor = backgroundColor
        messageAlert.text = message as String
        messageAlert.textColor = UIColor.white
        messageAlert.font = UIFont.boldSystemFont(ofSize: 15)
        messageAlert.textAlignment = .center
        self.view.addSubview(messageAlert)
        UIView.animate(withDuration: delayTime,
                       animations: {self.messageAlert.alpha = 0},
                       completion: { _ in self.messageAlert.removeFromSuperview()})
    }
    //圆点动画1
    func dotAnimation1() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        UIView.setAnimationRepeatCount(0.8)
        
        view_round1.removeFromSuperview()
        view_round2.removeFromSuperview()
        view_round3.removeFromSuperview()
        view_round4.removeFromSuperview()
        
        view_round1 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*4 + 3, y: 150, width: 14, height: 14))
        view_round1.layer.borderColor = greenColor.cgColor
        view_round1.backgroundColor = greenColor
        view_round1.layer.borderWidth = 1.5
        view_round1.layer.cornerRadius = 7
        view_round1.layer.masksToBounds = true
        self.view.addSubview(view_round1)
        view_round2 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*5 + 3, y: 150, width: 14, height: 14))
        view_round2.layer.borderColor = greenColor.cgColor
        view_round2.backgroundColor = greenColor
        view_round2.layer.borderWidth = 1.5
        view_round2.layer.cornerRadius = 7
        view_round2.layer.masksToBounds = true
        self.view.addSubview(view_round2)
        view_round3 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*6 + 3, y: 150, width: 14, height: 14))
        view_round3.layer.borderColor = greenColor.cgColor
        view_round3.backgroundColor = greenColor
        view_round3.layer.borderWidth = 1.5
        view_round3.layer.cornerRadius = 7
        view_round3.layer.masksToBounds = true
        self.view.addSubview(view_round3)
        view_round4 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*7 + 3, y: 150, width: 14, height: 14))
        view_round4.layer.borderColor = greenColor.cgColor
        view_round4.backgroundColor = greenColor
        view_round4.layer.borderWidth = 1.5
        view_round4.layer.cornerRadius = 7
        view_round4.layer.masksToBounds = true
        self.view.addSubview(view_round4)
        
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dotAnimation2))
        UIView.commitAnimations()
    }
    //圆点动画2
    func dotAnimation2() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        UIView.setAnimationRepeatCount(0.8)
        
        view_round1.removeFromSuperview()
        view_round2.removeFromSuperview()
        view_round3.removeFromSuperview()
        view_round4.removeFromSuperview()
        
        view_round1 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*4 - 17, y: 150, width: 14, height: 14))
        view_round1.layer.borderColor = greenColor.cgColor
        view_round1.backgroundColor = greenColor
        view_round1.layer.borderWidth = 1.5
        view_round1.layer.cornerRadius = 7
        view_round1.layer.masksToBounds = true
        self.view.addSubview(view_round1)
        view_round2 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*5 - 17, y: 150, width: 14, height: 14))
        view_round2.layer.borderColor = greenColor.cgColor
        view_round2.backgroundColor = greenColor
        view_round2.layer.borderWidth = 1.5
        view_round2.layer.cornerRadius = 7
        view_round2.layer.masksToBounds = true
        self.view.addSubview(view_round2)
        view_round3 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*6 - 17, y: 150, width: 14, height: 14))
        view_round3.layer.borderColor = greenColor.cgColor
        view_round3.backgroundColor = greenColor
        view_round3.layer.borderWidth = 1.5
        view_round3.layer.cornerRadius = 7
        view_round3.layer.masksToBounds = true
        self.view.addSubview(view_round3)
        view_round4 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*7 - 17, y: 150, width: 14, height: 14))
        view_round4.layer.borderColor = greenColor.cgColor
        view_round4.backgroundColor = greenColor
        view_round4.layer.borderWidth = 1.5
        view_round4.layer.cornerRadius = 7
        view_round4.layer.masksToBounds = true
        self.view.addSubview(view_round4)
        
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dotAnimation3))
        UIView.commitAnimations()
    }
    //圆点动画3
    func dotAnimation3() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        UIView.setAnimationRepeatCount(0.8)
        
        view_round1.removeFromSuperview()
        view_round2.removeFromSuperview()
        view_round3.removeFromSuperview()
        view_round4.removeFromSuperview()
        
        view_round1 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*4 - 7, y: 150, width: 14, height: 14))
        view_round1.layer.borderColor = greenColor.cgColor
        view_round1.layer.borderWidth = 1.5
        view_round1.layer.cornerRadius = 7
        view_round1.layer.masksToBounds = true
        self.view.addSubview(view_round1)
        view_round2 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*5 - 7, y: 150, width: 14, height: 14))
        view_round2.layer.borderColor = greenColor.cgColor
        view_round2.layer.borderWidth = 1.5
        view_round2.layer.cornerRadius = 7
        view_round2.layer.masksToBounds = true
        self.view.addSubview(view_round2)
        view_round3 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*6 - 7, y: 150, width: 14, height: 14))
        view_round3.layer.borderColor = greenColor.cgColor
        view_round3.layer.borderWidth = 1.5
        view_round3.layer.cornerRadius = 7
        view_round3.layer.masksToBounds = true
        self.view.addSubview(view_round3)
        view_round4 = UIView.init(frame: CGRect(x: (SCREEN_WIDTH/11)*7 - 7, y: 150, width: 14, height: 14))
        view_round4.layer.borderColor = greenColor.cgColor
        view_round4.layer.borderWidth = 1.5
        view_round4.layer.cornerRadius = 7
        view_round4.layer.masksToBounds = true
        self.view.addSubview(view_round4)
        
        UIView.commitAnimations()
        
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
