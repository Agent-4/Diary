//
//  CodedLockSetViewController.swift
//  Mo
//
//  Created by moxiaohao on 2017/1/3.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class CodedLockSetViewController: UIViewController {
    
    var SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    var SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var CodedLockSetViewNavBar: UINavigationBar!
    
    var round1: UIView!
    var round2: UIView!
    var round3: UIView!
    var round4: UIView!
    
    var getPWDFull: NSString!
    var inputCodedLockPWD: NSString!
    var saveCodedLockPWD: NSString!
    
    var getCodedArray: NSMutableArray!
    
    var messageAlert: UILabel!
    var getNumber: Int!
    var numberOfInput = 1
    
    @IBOutlet weak var infoRemindLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    var infoRemindLabel2: UILabel!
    var label5: UILabel!
    var label6: UILabel!
    var label7: UILabel!
    var label8: UILabel!
    
    @IBOutlet weak var resetBtn: UIButton!
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
    
    var greenBackgroundColor = UIColor.init(red: 58/255, green: 187/255, blue: 127/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillView?.py_add(toThemeColorPool: "backgroundColor")
        //去除导航栏底部黑线
        CodedLockSetViewNavBar?.py_add(toThemeColorPool: "barTintColor")
        CodedLockSetViewNavBar?.setBackgroundImage(UIImage(), for: .default)
        CodedLockSetViewNavBar?.shadowImage = UIImage()
        //初始化数组
        getCodedArray = NSMutableArray.init(capacity: 0)
        
        infoRemindLabel.frame = CGRect(x: SCREEN_WIDTH/2 - 60, y: 110, width: 120, height: 21)
        label1.frame = CGRect(x: (SCREEN_WIDTH/11)*4 - 7, y: 150, width: 14, height: 14)
        label2.frame = CGRect(x: (SCREEN_WIDTH/11)*5 - 7, y: 150, width: 14, height: 14)
        label3.frame = CGRect(x: (SCREEN_WIDTH/11)*6 - 7, y: 150, width: 14, height: 14)
        label4.frame = CGRect(x: (SCREEN_WIDTH/11)*7 - 7, y: 150, width: 14, height: 14)
        
        //密码圆点
        round1 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*4 - 7, y: 150, width: 14, height: 14))
        round1.layer.cornerRadius = 7
        round1.layer.masksToBounds = true
        self.view.addSubview(round1)
        
        round2 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*5 - 7, y: 150, width: 14, height: 14))
        round2.layer.cornerRadius = 7
        round2.layer.masksToBounds = true
        self.view.addSubview(round2)
        
        round3 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*6 - 7, y: 150, width: 14, height: 14))
        round3.layer.cornerRadius = 7
        round3.layer.masksToBounds = true
        self.view.addSubview(round3)
        
        round4 = UIView(frame: CGRect(x: (SCREEN_WIDTH/11)*7 - 7, y: 150, width: 14, height: 14))
        round4.layer.cornerRadius = 7
        round4.layer.masksToBounds = true
        self.view.addSubview(round4)
        
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
        resetBtn.frame = CGRect(x: (SCREEN_WIDTH/4)*3 - 13, y: SCREEN_HEIGHT - 65, width: 50, height: 50)
        resetBtn.layer.cornerRadius = 25
        
        //数字按钮添加动作
        number0.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number1.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number2.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number3.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number4.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number5.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number6.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number7.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number8.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        number9.addTarget(self, action: #selector(numberButtonClick), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetButtonClick), for: .touchUpInside)
        
    }
    //返回
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    //数字按钮点击响应事件
    func numberButtonClick(tagNumber: UIButton) {
        getNumber = tagNumber.tag
        getPWDFull = NSString.localizedStringWithFormat("%d", getNumber)
        getCodedArray.add(getPWDFull)
        inputCodedLockPWD = NSString.localizedStringWithFormat("%@", getCodedArray)
        
        print("输入密码:\n" + (inputCodedLockPWD! as String))
        
        //圆点显示判断
        if (round1.backgroundColor == nil) {
            round1.backgroundColor = green
        } else if (round2.backgroundColor == nil) {
            round1.backgroundColor = green
            round2.backgroundColor = green
        } else if (round3.backgroundColor == nil) {
            round1.backgroundColor = green
            round2.backgroundColor = green
            round3.backgroundColor = green
        } else if (round4.backgroundColor == nil) {
            round1.backgroundColor = green
            round2.backgroundColor = green
            round3.backgroundColor = green
            round4.backgroundColor = green
        }
        
        switch tagNumber.tag {
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
                            switch tagNumber.tag {
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
        
        //判断结构  判断两个字符串是否相等
        if (getCodedArray.count == 4) && numberOfInput == 1 {
            numberOfInput = 2
            //保存第一次输入的4位数字密码
            saveCodedLockPWD = NSString.localizedStringWithFormat("%@", getCodedArray)
            getCodedArray.removeAllObjects()
            
            label1.layer.cornerRadius = 7
            label1.backgroundColor = green
            label1.layer.masksToBounds = true
            label2.layer.cornerRadius = 7
            label2.backgroundColor = green
            label2.layer.masksToBounds = true
            label3.layer.cornerRadius = 7
            label3.backgroundColor = green
            label3.layer.masksToBounds = true
            label4.layer.cornerRadius = 7
            label4.backgroundColor = green
            label4.layer.masksToBounds = true
            
            infoRemindLabel2 = UILabel(frame: CGRect(x: SCREEN_WIDTH + SCREEN_WIDTH/2 - 74, y: 110, width: 148, height: 21))
            infoRemindLabel2.text = "请再次输入4位密码"
            infoRemindLabel2.font = UIFont.boldSystemFont(ofSize: 16)
            infoRemindLabel2.textColor = green
            infoRemindLabel2.textAlignment = .center
            self.view.addSubview(infoRemindLabel2)
            
            label5 = UILabel(frame: CGRect(x: SCREEN_WIDTH + (SCREEN_WIDTH/11)*4 - 7, y: 148, width: 14, height: 14))
            label5.text = "-"
            label5.textColor = green
            label5.textAlignment = .center
            label5.font = UIFont.systemFont(ofSize: 28)
            self.view.addSubview(label5)
            label6 = UILabel(frame: CGRect(x: SCREEN_WIDTH + (SCREEN_WIDTH/11)*5 - 7, y: 148, width: 14, height: 14))
            label6.text = "-"
            label6.textColor = green
            label6.textAlignment = .center
            label6.font = UIFont.systemFont(ofSize: 28)
            self.view.addSubview(label6)
            label7 = UILabel(frame: CGRect(x: SCREEN_WIDTH + (SCREEN_WIDTH/11)*6 - 7, y: 148, width: 14, height: 14))
            label7.text = "-"
            label7.textColor = green
            label7.textAlignment = .center
            label7.font = UIFont.systemFont(ofSize: 28)
            self.view.addSubview(label7)
            label8 = UILabel(frame: CGRect(x: SCREEN_WIDTH + (SCREEN_WIDTH/11)*7 - 7, y: 148, width: 14, height: 14))
            label8.text = "-"
            label8.textColor = green
            label8.textAlignment = .center
            label8.font = UIFont.systemFont(ofSize: 28)
            self.view.addSubview(label8)
            
            self.round1.backgroundColor = nil
            self.round2.backgroundColor = nil
            self.round3.backgroundColor = nil
            self.round4.backgroundColor = nil
            
            UIView.animate(withDuration: 0.5, delay: 0.2, options: [],
                animations: {
                    self.infoRemindLabel.frame.origin.x = -(self.SCREEN_WIDTH/2 + 60)
                    self.label1.frame.origin.x = -((self.SCREEN_WIDTH/11)*7 + 7)
                    self.label2.frame.origin.x = -((self.SCREEN_WIDTH/11)*6 + 7)
                    self.label3.frame.origin.x = -((self.SCREEN_WIDTH/11)*5 + 7)
                    self.label4.frame.origin.x = -((self.SCREEN_WIDTH/11)*4 + 7)
                    self.infoRemindLabel2.frame.origin.x = self.SCREEN_WIDTH/2 - 74
                    self.label5.frame.origin.x = (self.SCREEN_WIDTH/11)*4 - 7
                    self.label6.frame.origin.x = (self.SCREEN_WIDTH/11)*5 - 7
                    self.label7.frame.origin.x = (self.SCREEN_WIDTH/11)*6 - 7
                    self.label8.frame.origin.x = (self.SCREEN_WIDTH/11)*7 - 7
                },
                completion: { _ in
                    self.label1.removeFromSuperview()
                    self.label2.removeFromSuperview()
                    self.label3.removeFromSuperview()
                    self.label4.removeFromSuperview()
                    self.infoRemindLabel.removeFromSuperview()
                })
            
        }
        else if !(inputCodedLockPWD .isEqual(saveCodedLockPWD)) && (getCodedArray.count == 4) && (numberOfInput == 2) {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                self.round1.backgroundColor = nil
                self.round2.backgroundColor = nil
                self.round3.backgroundColor = nil
                self.round4.backgroundColor = nil
            }
            getCodedArray.removeAllObjects()
            showMessage(message: "两次密码不一致,请重输", delayTime: 1.8)
        }
        else if((inputCodedLockPWD .isEqual(saveCodedLockPWD)) && (getCodedArray.count == 4) && (numberOfInput == 2)) {
            let saveTheCodedLockPWD = UserDefaults.standard
            saveTheCodedLockPWD.set(inputCodedLockPWD, forKey: "theCodedLockPWD")
            getCodedArray.removeAllObjects()
            Drop.down("已设置密码锁", state: .color(green), duration: 1.0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //删除按钮响应事件
    func resetButtonClick() {
        round1.backgroundColor = nil
        round2.backgroundColor = nil
        round3.backgroundColor = nil
        round4.backgroundColor = nil
        resetBtn.backgroundColor = UIColor.init(red: 255/255, green: 69/255, blue: 75/255, alpha: 0.3)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowUserInteraction],
                       animations: { self.resetBtn.backgroundColor = nil }, completion: nil)
        getCodedArray.removeAllObjects()
    }
    
    //信息提示条
    func showMessage(message: NSString, delayTime: TimeInterval) {
        messageAlert = UILabel.init(frame: CGRect(x: SCREEN_WIDTH/2 - 90, y: 210, width: 180, height: 30))
        messageAlert.layer.cornerRadius = 4
        messageAlert.layer.masksToBounds = true
        messageAlert.backgroundColor = #colorLiteral(red: 1, green: 0.3722903728, blue: 0.3634029031, alpha: 1)
        messageAlert.text = message as String
        messageAlert.textColor = UIColor.white
        messageAlert.font = UIFont.boldSystemFont(ofSize: 15)
        messageAlert.textAlignment = .center
        self.view.addSubview(messageAlert)
        UIView.animate(withDuration: delayTime,
                       animations: {self.messageAlert.alpha = 0},
                       completion: { _ in self.messageAlert.removeFromSuperview()})
    }
    
    // 设置statusBar颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
