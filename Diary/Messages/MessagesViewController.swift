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
        ["image1":"messagesAT.png"],
        ["image1":"messagesComment.png"],
        ["image1":"messagesSystem.png"]
    ]
    
    @IBOutlet weak var MessagesNavigationBar: UINavigationBar!
    @IBOutlet weak var MessageTopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        createMessagesTableView()

    }
    
    func createMessagesTableView() {
        self.messagesList =  [
            0:[String]([
                "@我的",
                "评论",
                "系统消息"])
        ]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height),style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
//        let Nav1 = UINib(nibName:"MessagesNavigationBarView", bundle:nil)
//        let NavBar = Nav1.instantiate(withOwner: self, options: nil).first as! UIView
        
        view.addSubview(tableView)
//        view.addSubview(NavBar)
        //去除Navigation Bar 底部黑线
        MessagesNavigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        MessagesNavigationBar.shadowImage = UIImage()
        tableView.addSubview(MessageTopView)
        tableView.addSubview(MessagesNavigationBar)
        tableView.tableFooterView = UIView(frame:CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
    //点击cell行时，让cell背景颜色一闪而过
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            let viewController = SettingViewController()
            viewController.hidesBottomBarWhenPushed = true
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: UIBarButtonItemStyle.plain,target: nil, action: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "messagesCellID"
        var messagesCell = tableView.dequeueReusableCell(withIdentifier: cellID)
        messagesCell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        let data = self.messagesList?[indexPath.section]
        let messagesItem = messagesImgData[indexPath.row]
        let rightIcon1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon1.image = UIImage(named: "arrow_Right")
        
        messagesCell?.accessoryView = rightIcon1
        messagesCell?.textLabel?.text = data![indexPath.row]
        messagesCell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
//        let Marr = ["messageAT.png","GuideImage2.jpg","GuideImage3.jpg","messageAT.png"]
//        
//        for i in 0 ..< Marr.count{
//            let MimageView = UIImageView.init(frame: CGRect(x: 12, y: 9.5, width: 30, height: 30))
//            MimageView.image = UIImage(named: Marr[i])
//            cell?.imageView?.image = MimageView.image
//        }
////        if indexPath.row == 0 {
////            
////        }
        messagesCell?.imageView?.image = UIImage(named: messagesItem["image1"]!)
        //修改cell选中的背景色
        messagesCell?.selectedBackgroundView = UIView.init()
        messagesCell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        
        return messagesCell!
    }
    
    //设置statusBar颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
