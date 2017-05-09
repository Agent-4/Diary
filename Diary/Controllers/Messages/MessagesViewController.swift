//
//  MessagesViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/3.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var messagesList: Dictionary<Int, [String]>?
    
    var messagesImgData = [
        ["icon":"messagesAT.png"],
        ["icon":"messagesSystem.png"]
    ]
    
    @IBOutlet weak var MessagesNavigationBar: UINavigationBar!
    @IBOutlet weak var MessageTopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        createMessagesTableView()

    }
    
    func createMessagesTableView() {
        self.messagesList =  [0:[String](["赞我的","系统消息"])]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        view.addSubview(tableView)
        //去除Navigation Bar 底部黑线
        MessagesNavigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        MessagesNavigationBar.shadowImage = UIImage()
        MessagesNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        MessageTopView?.py_add(toThemeColorPool: "backgroundColor")
        tableView.addSubview(MessageTopView)
        tableView.addSubview(MessagesNavigationBar)
        tableView.tableFooterView = UIView(frame:CGRect.zero)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 54
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    //cell 数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "messagesCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        let data = self.messagesList?[indexPath.section]
        let messagesItem = messagesImgData[indexPath.row]
        let rightIcon1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon1.image = UIImage(named: "arrow_Right")
        
        cell?.accessoryView = rightIcon1
        cell?.textLabel?.text = data![indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.imageView?.image = UIImage(named: messagesItem["icon"]!)
//        cell?.detailTextLabel?.text = "\(indexPath.row)"
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
    }
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
