//
//  MeViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/30.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud
import Kingfisher

class MeViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, photoPreviewDelegate {
    // 顶部图片高度
    fileprivate let topImageHeight: CGFloat = 200
    // 顶部图片
    fileprivate var topImage: UIImageView?
    // 头像
    fileprivate var myAvatar: UIImageView?
    // 昵称
    fileprivate var myNickName: UILabel?
    // 个性签名
    fileprivate var myBio: UILabel?
    
    fileprivate var c_user = AVUser.current()
    
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
    override func viewWillAppear(_ animated: Bool) {
        if let user_bio = c_user?.value(forKey: "bio") {
            myBio?.text = user_bio as? String
        }else {
            myBio?.text = nil
        }
        if let nick_name = c_user?.value(forKey: "nickName") {
            myNickName?.text = nick_name as? String
        }else {
            myNickName?.text = c_user?.username
        }
        if let avatarURL = c_user?.value(forKey: "avatar") {
            let url = URL(string: avatarURL as! String)
            myAvatar?.kf.setImage(with: url)
        }else {
            myAvatar?.image = UIImage(named: "avatar")
        }
        if let bgPicURL = c_user?.value(forKey: "bgPicture") {
            let url = URL(string: bgPicURL as! String)
            topImage?.kf.setImage(with: url)
        }else {
            topImage?.image = UIImage(named: "secret")
        }
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
        if let avatarURL = c_user?.value(forKey: "avatar") {
            let url = URL(string: avatarURL as! String)
            avatar.kf.setImage(with: url)
        }else {
            avatar.image = UIImage(named: "avatar")
        }
        avatar.backgroundColor = UIColor.white
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = avatar.frame.width / 2.0
        avatar.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
        avatar.layer.borderWidth = 1.5
        avatar.clipsToBounds = true
        myAvatar = avatar
        myAvatar?.isUserInteractionEnabled = true
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(meImgTap))
        myAvatar?.addGestureRecognizer(imgTap)
        
        //昵称
        let nickName = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 140, y: 157, width: 280, height: 21))
        if let nick_name = c_user?.value(forKey: "nickName") {
            nickName.text = nick_name as? String
        }else {
            nickName.text = c_user?.username
        }
        nickName.textColor = UIColor.white
        nickName.textAlignment = .center
        nickName.font = UIFont.systemFont(ofSize: 14.0)
        myNickName = nickName
        
        //个性签名
        let bio = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 150, y: 175, width: 300, height: 21))
        if let user_bio = c_user?.value(forKey: "bio") {
            bio.text = user_bio as? String
        }else {
            bio.text = nil
        }
        bio.textColor = UIColor.white
        bio.textAlignment = .center
        bio.font = UIFont.systemFont(ofSize: 11.0)
        myBio = bio
        
        //顶部图片
        let topImg = UIImageView(frame: CGRect(x: 0, y:-topImageHeight, width: view.bounds.width, height: topImageHeight))
        if let bgPicURL = c_user?.value(forKey: "bgPicture") {
            let url = URL(string: bgPicURL as! String)
            topImg.kf.setImage(with: url)
        }else {
            topImg.image = UIImage(named: "secret")
        }
        topImg.contentMode = .scaleAspectFill
        topImg.clipsToBounds = true
        topImage = topImg
//        topImage?.addSubview(myAvatar!)
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
        
        self.view.addSubview(myAvatar!)
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
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    // cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "MeCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        var data = self.meAllCellNames?[indexPath.section]
        let meItem = meImgData[indexPath.row]
        cell?.textLabel?.text = data![indexPath.row]
        
        let rightIcon1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon1.image = UIImage(named: "arrow_Right")
        rightIcon = rightIcon1
        cell?.accessoryView = rightIcon
        if indexPath.section == 0 {
            cell?.imageView?.image = UIImage(named: meItem["image0"]!)
        }else {
            if (indexPath.row == 0){
                let nightStyleSwitch = UISwitch(frame: CGRect.zero)
                nightStyleSwitch.isOn = false
                nightStyleSwitch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
                nightSwitch = nightStyleSwitch
                cell?.accessoryView = nightSwitch
                cell?.selectionStyle = .none
            }
            cell?.imageView?.image = UIImage(named: meItem["image1"]!)
        }
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
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
        }else {
            myAvatar?.frame.origin.y = -offY - topImageHeight + 75
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
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = ProfileViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1 {
                let vc = HistoryViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let vc = MoreFeaturesViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let vc = SettingViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func meImgTap() {
        let photoView = MOPhotoPreviewer()
        photoView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        photoView.preview(fromImageView: myAvatar!, container: self.view)
    }
    
    // photoView 委托
    func viewSetting() {
        self.tabBarController?.tabBar.isHidden = false
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
