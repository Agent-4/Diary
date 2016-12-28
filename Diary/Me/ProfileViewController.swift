//
//  ProfileViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/20.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "MeCellID"
        var meCell = tableView.dequeueReusableCell(withIdentifier: cellID)
        meCell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        meCell?.textLabel?.text = " cell \(indexPath.row)"

        //修改cell选中的背景色
        meCell?.selectedBackgroundView = UIView.init()
        meCell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return meCell!
    }

}
