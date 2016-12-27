//
//  MeViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/30.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class MeViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    //顶部图片高度
    private let topImageHeight: CGFloat = 200
    // 顶部图片
    private var topImage: UIImageView?
    private var myAvatar: UIImageView?
    private var myNickName: UILabel?
    private var myBio: UILabel?
    
    var meAllCellNames: Dictionary<Int, [String]>?
    var nightSwitch: UISwitch!
    var rightIcon: UIImageView!
    
    var meImgData = [
        ["image0":"profile.png", "image1":"night.png"],
        ["image0":"time.png", "image1":"setting.png"],
        ["image0":"more.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        createMeTableView()
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    func createMeTableView() {
        self.meAllCellNames =  [
            0:[String](["个人资料","历史","更多功能"]),
            1:[String](["夜间模式","设置"])
        ]
        
        //头像
        let avatar = UIImageView(frame: CGRect(x: self.view.frame.width / 2 - 40, y: 75, width: 80, height: 80))
        avatar.image = UIImage(named: "MyAvatar")
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = avatar.frame.width / 2.0
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 1.5
        avatar.clipsToBounds = true
        myAvatar = avatar
        
        //昵称
        let nickName = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 40, y: 157, width: 80, height: 21))
        nickName.text = "FOUR"
        nickName.textColor = UIColor.white
        nickName.textAlignment = .center
        nickName.font = UIFont.systemFont(ofSize: 14.0)
        myNickName = nickName
        
        //个性签名
        let bio = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 144, y: 175, width: 288, height: 21))
        bio.text = "有一天，带你去旅行哦！有一天，带你去旅行哦！有一天，带你去旅行哦！"
        bio.textColor = UIColor.white
        bio.textAlignment = .center
        bio.font = UIFont.systemFont(ofSize: 11.0)
        myBio = bio
        
        //顶部图片
        let topImg = UIImageView(frame: CGRect(x: 0, y:-topImageHeight, width: view.bounds.width, height: topImageHeight))
        topImg.image = UIImage(named: "secret")
        topImg.contentMode = .scaleAspectFill
        topImg.clipsToBounds = true
        topImage = topImg
        topImage?.addSubview(myAvatar!)
        topImage?.addSubview(myNickName!)
        topImage?.addSubview(myBio!)
        
        //tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        tableView.addSubview(topImage!)
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else{
            return 2
        }
    }
    
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "MeCellID"
        var meCell = tableView.dequeueReusableCell(withIdentifier: cellID)
        meCell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        var data = self.meAllCellNames?[indexPath.section]
        let meItem = meImgData[indexPath.row]
        meCell?.textLabel?.text = data![indexPath.row]
        
        let rightIcon1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon1.image = UIImage(named: "arrow_Right")
        rightIcon = rightIcon1
        meCell?.accessoryView = rightIcon
        if indexPath.section == 0 {
            meCell?.imageView?.image = UIImage(named: meItem["image0"]!)
        }else {
            if (indexPath.row == 0){
                let nightStyleSwitch = UISwitch(frame: CGRect.zero)
                nightStyleSwitch.isOn = false
                nightStyleSwitch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
                nightSwitch = nightStyleSwitch
                meCell?.accessoryView = nightSwitch
                meCell?.selectionStyle = .none
            }
            meCell?.imageView?.image = UIImage(named: meItem["image1"]!)
        }
        //修改cell选中的背景色
        meCell?.selectedBackgroundView = UIView.init()
        meCell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return meCell!
    }
    
    //ScrollView代理，以实现下拉图片放大
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < -topImageHeight {
            topImage?.frame.origin.y = offY
            topImage?.frame.size.height = -offY
            myAvatar?.frame.origin.y = -offY - topImageHeight + 75
            myNickName?.frame.origin.y = -offY - topImageHeight + 157
            myBio?.frame.origin.y = -offY - topImageHeight + 175
        }
    }
    
    //开关
    func switchChange() {
        if nightSwitch.isOn {
            let alertController = UIAlertController(title: "", message: "夜间模式正在努力开发中，等一下下！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: {self.nightSwitch.isOn = false})
        }
    }
    
    //点击cell行时，让cell背景颜色一闪而过
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let viewController = ProfileViewController()
                viewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let viewController = SettingViewController()
                viewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
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
