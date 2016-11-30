//
//  MeViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/30.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let btn=UIButton(frame: CGRect(x: 20, y: 120,width: 320, height: 36))
//        btn.setTitle("弹出第二个视图", for: UIControlState.normal)
//        btn.setTitleColor(UIColor.blue, for:UIControlState.normal)
//        btn.addTarget(self, action: #selector(MeViewController.openAct), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(btn)
 
        self.view.backgroundColor = UIColor.white
        
        
    }

    
    /**
    func nextPage(){
        let secondVC = SettingViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    **/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
