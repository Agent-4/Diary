//
//  AppDelegate.swift
//  Diary
//
//  Created by moxiaohao on 16/9/27.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, QQApiInterfaceDelegate {

    var window: UIWindow?
    
    //重写openURL
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        QQApiInterface.handleOpen(url, delegate: self)
        return TencentOAuth.handleOpen(url)
    }
    
    //处理来至QQ的响应
    func onResp(_ resp: QQBaseResp!) {
        print("--- onResp ---")
        //确保是对我们QQ分享操作的回调
        if resp.isKind(of: SendMessageToQQResp.self) {
            //QQApi应答消息类型判断（手Q -> 第三方应用，手Q应答处理分享消息的结果）
            if uint(resp.type) == ESENDMESSAGETOQQRESPTYPE.rawValue {
                let title = resp.result == "0" ? "分享成功" : "分享失败"
                var message = ""
                switch(resp.result){
                case "-1":
                    message = "参数错误"
                case "-2":
                    message = "该群不在自己的群列表里面"
                case "-3":
                    message = "上传图片失败"
                case "-4":
                    message = "你放弃了分享操作"
                case "-5":
                    message = "客户端内部处理错误"
                default: //0
                    //message = "成功"
                    break
                }
                
                //显示消息
                showAlert(title: title, message: message)
            }
        }
    }
    
    //处理来至QQ的请求
    func onReq(_ req:QQBaseReq!){
        print("--- onReq ---")
    }
    
    //处理QQ在线状态的回调
    func isOnlineResponse(_ response: [AnyHashable : Any]!) {
        print("--- isOnlineResponse ---")
    }
    
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.window?.rootViewController!.present(alertController, animated: true,
                                                 completion: nil)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AVOSCloud.setApplicationId("Your Id", clientKey: "Your Key")
        //添加标识，用于判断是否是第一次启动应用....
        buildKeyWindow()
        
        return true
    }
    
    private func buildKeyWindow() {
        
        window = UIWindow(frame: (self.window?.bounds)!)
        window!.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        if (UserDefaults.standard.object(forKey: "fristTimeOpenApp") == nil) {
            UserDefaults.standard.set("fristTimeOpenApp", forKey: "fristTimeOpenApp")
            self.window!.rootViewController = GuideViewController()
        }else {
            
            let savePWD = UserDefaults.standard
            
            if ((savePWD.object(forKey: "theCodedLockPWD")) != nil){
                print("密码是:\n" + savePWD.string(forKey: "theCodedLockPWD")!)
                let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                window?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "AppLockView")
                loadAds()
            }else {
                print("没有设置密码锁！")
                let currentUser = AVUser.current()
                if (currentUser != nil) {
                    // 跳转到首页
                    let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    self.window?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
                    loadAds()
                } else {
                    //缓存用户对象为空时，打开用户注册界面…
                    let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    self.window?.rootViewController = mainStoryboard.instantiateInitialViewController()
                    loadAds()
                }
            }
            UserDefaults.standard.set("fristTimeOpenApp", forKey: "fristTimeOpenApp")
        }
    }
    
    func loadAds() {
        let adsView = MOAdsView(frame: UIScreen.main.bounds, location: .topRightCorner, type: .oval)
        let image = UIImage(named: "GuideImage4")
        adsView.imageView.image = image
//        let urlStr = NSURL.init(string: "http://7xsjfr.com1.z0.glb.clouddn.com/pet07.JPG")! as URL
//        let imageData = NSData.init(contentsOf: urlStr)! as Data
//        adsView.imageView.image = UIImage.init(data: imageData)
        window?.addSubview(adsView)
        adsView.start()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

