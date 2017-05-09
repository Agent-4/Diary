//
//  FeedbackViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/26.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class FeedbackViewController: UIViewController, UITextViewDelegate {
    
    fileprivate var feedbackTextView: UITextView?
    fileprivate var submitButton: UIButton?
    fileprivate var placeholderLabel: UILabel?
    
    fileprivate var c_user = AVUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        createNavBar()
        
        // 意见反馈输入框 textView
        feedbackTextView = UITextView(frame: CGRect(x: 10, y: 74, width: self.view.frame.width - 20, height: 120))
        feedbackTextView?.delegate = self
        feedbackTextView?.backgroundColor = UIColor.white
        feedbackTextView?.font = UIFont.systemFont(ofSize: 14)
        feedbackTextView?.tintColor = green
        feedbackTextView?.isEditable = true
        feedbackTextView?.isScrollEnabled = true
        self.view.addSubview(feedbackTextView!)
        
        // 占位符 用 Label 代替
        placeholderLabel = UILabel(frame: CGRect(x: 15, y: 80, width: 120, height: 21))
        placeholderLabel?.text = "说说你的看法或建议"
        placeholderLabel?.textColor = UIColor.lightGray
        placeholderLabel?.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(placeholderLabel!)
        
        // 提交按钮
        submitButton = UIButton.init(frame: CGRect(x: 10, y: 210, width: self.view.frame.width - 20, height: 40))
        submitButton?.setTitle("提交", for: .normal)
        submitButton?.setTitleColor(UIColor.white, for: .normal)
        submitButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        submitButton?.backgroundColor = red
        submitButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        submitButton?.layer.cornerRadius = 2
        submitButton?.addTarget(self, action: #selector(feedback), for: .touchUpInside)
        self.view.addSubview(submitButton!)
        submitButton?.isEnabled = false
        
        let infoLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.height - 40, width: 200, height: 21))
        infoLabel.text = "您的建议能让 留忆 变得更好！"
        infoLabel.textColor = UIColor.gray
        infoLabel.font = UIFont.systemFont(ofSize: 13)
        infoLabel.textAlignment = .center
        self.view.addSubview(infoLabel)
    }
    
    // 意见反馈
    func feedback() {
        let reachability = Reachability.init()
        if (reachability?.isReachable)! {
            submitButton?.isEnabled = false
            let newFeedback = AVObject(className: "Feedback")
            newFeedback.setObject(feedbackTextView?.text, forKey: "main_content")
            newFeedback.setObject(c_user?.username, forKey: "username")
            if let eamil = c_user?.email {
                newFeedback.setObject(eamil, forKey: "email")
            }
            if let phone = c_user?.mobilePhoneNumber {
                newFeedback.setObject(phone, forKey: "mobilePhone")
            }
            
            newFeedback.saveInBackground { (succeeded, error) in
                if succeeded {
                    Drop.down("反馈成功，感谢您的反馈！", state: .color(green), duration: 1.4)
                    Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                }
            }
        }else {
            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
        }
        
    }
    
    // textView 改变后
    func textViewDidChange(_ textView: UITextView) {
        let string = feedbackTextView?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if feedbackTextView?.text == "" || string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            placeholderLabel?.isHidden = false
            submitButton?.isEnabled = false
        }else {
            placeholderLabel?.isHidden = true
            submitButton?.isEnabled = true
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
        navigationItem.title = "意见反馈"
        //设置导航项左右边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    
    //返回上一级页面
    func back() {
        _ = navigationController?.popViewController(animated: true)
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
