//
//  SettingViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/10/18.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "设置"
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.view.backgroundColor = UIColor.white
                
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
