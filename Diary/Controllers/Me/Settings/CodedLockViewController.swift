//
//  CodedLockViewController.swift
//  Mo
//
//  Created by 莫晓豪 on 2017/1/2.
//  Copyright © 2017年 莫晓豪. All rights reserved.
//

import UIKit

class CodedLockViewController: UIViewController {


    @IBOutlet weak var codedLockSwitch: UISwitch!
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var CodedLockViewNavBar: UINavigationBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去除导航栏底部黑线
        fillView?.py_add(toThemeColorPool: "backgroundColor")
        CodedLockViewNavBar?.py_add(toThemeColorPool: "barTintColor")
        CodedLockViewNavBar?.setBackgroundImage(UIImage(), for: .default)
        CodedLockViewNavBar?.shadowImage = UIImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        //密码锁开关初始状态设置
        if (UserDefaults.standard.string(forKey: "theCodedLockPWD") != nil) {
            codedLockSwitch.isOn = true
        } else {
            codedLockSwitch.isOn = false
        }
    }
    @IBAction func CodedLockSetSwitch(_ sender: UISwitch) {
        if (codedLockSwitch.isOn) {
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CodedLockSetViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            Drop.down("已关闭密码锁!", state: .color(green), duration: 1.2)
            UserDefaults.standard.removeObject(forKey: "theCodedLockPWD")
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
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
