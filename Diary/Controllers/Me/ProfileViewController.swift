//
//  ProfileViewController.swift
//  Diary
//
//  Created by moxiaohao on 2016/12/20.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import Photos
import AVOSCloud


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var navBar:UINavigationBar?
    var tableView: UITableView!
    var userAvatar:UIImageView!
    var bgPicture:UIImageView!
    var avatarImage = UIImage(named: "avatar")
    var bgPic = UIImage(named: "secret")
    
    var setAvatarOrBgPic = true
//    var dateString : String = current_user?.value(forKey: "birthday") as! String
    fileprivate var c_user = AVUser.current()
    let reachability = Reachability.init()
    var cellTitle: String?
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        tableView.separatorColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        self.view.addSubview(tableView)
        
        //导航栏
        createNavBar()
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row: Int = 0
        switch section {
            case 0:
                row = 2
            case 1:
                row = 3
            case 2:
                row = 3
            default:
                row = 1
        }
        return row
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var cellHeight: CGFloat = 0.0
        if (indexPath.section == 0) {
            if indexPath.row == 0 {
                cellHeight = 64.0
            }else {
                cellHeight = 50.0
            }
        }else {
            cellHeight = 50.0
        }
        return cellHeight
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "profileCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        
        let rightIcon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon.image = UIImage(named: "arrow_Right")
        cell?.accessoryView = rightIcon
        switch (indexPath.section) {
            case 0:
                if indexPath.row == 0 {
                    cell?.textLabel?.text = "头像"
                    userAvatar = UIImageView.init(frame: CGRect(x: (self.view.frame.width) - 85, y: 7, width: 50, height: 50))
                    if let avatarURL = c_user?.value(forKey: "avatar") {
                        let url = URL(string: avatarURL as! String)
                        userAvatar.kf.setImage(with: url)
                    }else {
                        userAvatar.image = avatarImage
                    }
                    userAvatar.contentMode = .scaleAspectFill
                    userAvatar.layer.cornerRadius = 25
                    userAvatar.layer.masksToBounds = true
                    cell?.contentView.addSubview(userAvatar)
                }else {
                    cell?.textLabel?.text = "背景"
                    bgPicture = UIImageView.init(frame: CGRect(x: (self.view.frame.width) - 73, y: 8, width: 34, height: 34))
                    if let avatarURL = c_user?.value(forKey: "bgPicture") {
                        let url = URL(string: avatarURL as! String)
                        bgPicture.kf.setImage(with: url)
                    }else {
                        bgPicture.image = bgPic
                    }
                    bgPicture.contentMode = .scaleAspectFill
                    //                    bgPicture.layer.cornerRadius = 25
                    //                    bgPicture.layer.masksToBounds = true
                    cell?.contentView.addSubview(bgPicture)
                }
            
            
            case 1:
                if (indexPath.row == 0) {
                    cell?.textLabel?.text = "用户名"
                    cell?.detailTextLabel?.text = c_user?.username
                }else if (indexPath.row == 1) {
                    cell?.textLabel?.text = "昵称"
                    if let nick_name = c_user?.value(forKey: "nickName"){
                        cell?.detailTextLabel?.text = nick_name as? String
                    }else {
                        cell?.detailTextLabel?.text = ""
                    }
                }else {
                    cell?.textLabel?.text = "签名"
                    if let bio = c_user?.value(forKey: "bio") {
                        cell?.detailTextLabel?.text = bio as? String
                    }else {
                        cell?.detailTextLabel?.text = ""
                    }
                }
            case 2:
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "性别"
                    if let gender = c_user?.value(forKey: "gender") {
                        cell?.detailTextLabel?.text = gender as? String
                    }else {
                        cell?.detailTextLabel?.text = "未知"
                    }
                case 1:
                    cell?.textLabel?.text = "生日"
                    if let dateString = c_user?.value(forKey: "birthday") {
                        cell?.detailTextLabel?.text = dateString as? String
                    }else {
                        cell?.detailTextLabel?.text = nil
                    }
                case 2:
                    cell?.textLabel?.text = "地区"
                    if let areaString = c_user?.value(forKey: "area") {
                        cell?.detailTextLabel?.text = areaString as? String
                    }else {
                        cell?.detailTextLabel?.text = nil
                    }
                default:
                    break
                }
            default:
                break
        }
        cell?.detailTextLabel?.textColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        switch (indexPath.section) {
            case 0:
                if indexPath.row == 0 {
                    let alertController = UIAlertController(title: "更换头像", message: nil, preferredStyle: .actionSheet)
                    let cameraAction = UIAlertAction(title: "拍照", style: .destructive, handler: { (action) in
                        if self.authorize() {
                            self.setAvatarOrBgPic = true
                            self.getPhoto(type: 0)
                        }else {
                            print("获取照片错误！")
                        }
                    })
                    let albumAction = UIAlertAction(title: "从相册选择", style: .default, handler: { (action) in
                        if self.authorize() {
                            self.setAvatarOrBgPic = true
                            self.getPhoto(type: 1)
                        }else {
                            print("获取相册错误！")
                        }
                    })
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    alertController.addAction(cameraAction)
                    alertController.addAction(albumAction)
                    self.present(alertController, animated: true, completion: nil)
                }else {
                    let alertController = UIAlertController(title: "更换背景图片", message: nil, preferredStyle: .actionSheet)
                    let cameraAction = UIAlertAction(title: "拍照", style: .destructive, handler: { (action) in
                        if self.authorize() {
                            self.setAvatarOrBgPic = false
                            self.getPhoto(type: 0)
                        }else {
                            print("获取照片错误！")
                        }
                    })
                    let albumAction = UIAlertAction(title: "从相册选择", style: .default, handler: { (action) in
                        if self.authorize() {
                            self.setAvatarOrBgPic = false
                            self.getPhoto(type: 1)
                        }else {
                            print("获取相册错误！")
                        }
                    })
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    alertController.addAction(cameraAction)
                    alertController.addAction(albumAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            
            case 1:
                if (indexPath.row == 1) {
                    cellTitle = cell?.textLabel?.text
                    let vc = SettingTextViewController()
                    vc.navTitle = cellTitle
                    vc.textString = cell?.detailTextLabel?.text
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if (indexPath.row == 2){
                    cellTitle = cell?.textLabel?.text
                    let vc = SettingTextViewController()
                    vc.navTitle = cellTitle
                    vc.textString = cell?.detailTextLabel?.text
                    self.navigationController?.pushViewController(vc, animated: true)
                }else {
                    cell?.selectionStyle = .none
                }
            case 2:
                switch indexPath.row {
                    case 0:
                        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                        let maleAction = UIAlertAction(title: "男", style: .default, handler: { (action) in
                            if (self.reachability?.isReachable)! {
                                self.c_user?.setObject("男", forKey: "gender")
                                self.c_user?.saveInBackground()
                                tableView.reloadData()
                            }else {
                                Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                            }
                        })
                        let femaleAction = UIAlertAction(title: "女", style: .destructive, handler: { (action) in
                            if (self.reachability?.isReachable)! {
                                self.c_user?.setObject("女", forKey: "gender")
                                self.c_user?.saveInBackground()
                                tableView.reloadData()
                            }else {
                                Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                            }
                        })
                        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        alertController.addAction(maleAction)
                        alertController.addAction(femaleAction)
                        self.present(alertController, animated: true, completion: nil)
                    case 1:
                        let picker = MoPicker.init(delegate: self, style: .date)
                        picker.max_Date = Date() // 初始最大日期 = now
                        picker.min_Date = Date.init(timeIntervalSinceNow: -1577923200) // 初始最小日期 = now - 50年
                        picker.show()
                    case 2:
                        var contentArray = [MoPickerObject]()
                        let plistPath:String = Bundle.main.path(forAuxiliaryExecutable: "areas.plist") ?? ""
                        let plistArray = NSArray(contentsOfFile: plistPath)
                        let proviceArray = NSArray(array: plistArray!)
                        for i in 0..<proviceArray.count {
                            var subs0 = [MoPickerObject]()
                            let cityzzz:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                            let cityArray:NSArray = cityzzz.value(forKey: "cities") as! NSArray
                            for j in 0..<cityArray.count {
                                let citymmm:NSDictionary = cityArray.object(at: j) as! NSDictionary
                                let cityStr:String = citymmm.value(forKey: "city") as! String
                                let object = MoPickerObject()
                                object.title = cityStr
                                subs0.append(object)
                            }
                            let provicemmm:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                            let proviceStr:String? = provicemmm.value(forKey: "state") as! String?
                            let object = MoPickerObject()
                            object.title = proviceStr
                            object.subArray = subs0
                            contentArray.append(object)
                        }
                        let picker = MoPicker(delegate: self, style: .nomal)
                        picker.contentArray = contentArray
                        picker.show()
                    default:
                        break
                    }
            default:
                break
        }
    }
    
    func getPhoto(type: Int) {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.allowsEditing = true//设置可编辑
        if type == 0 {
            picker.sourceType = .camera
        }else {
            picker.sourceType = .photoLibrary
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        if setAvatarOrBgPic == true {
            avatarImage = image
            if (reachability?.isReachable)! {
                let imageData = UIImageJPEGRepresentation(image, 0.5)
                let file = AVFile.init(name: "avatar.jpg", data: imageData!)
                file.saveInBackground { (succeeded, error) in
                    if succeeded {
                        if let avatarId = self.c_user?.value(forKey: "avatarId") {
                            let oldAvatarFile = AVFile()
                            oldAvatarFile.objectId = avatarId as? String
                            oldAvatarFile.deleteInBackground({ (succeeded, error) in
                                if succeeded {
                                    print("成功！")
                                }else {
                                    let errors = error! as NSError
                                    print(errors)
                                }
                            })
                        }
                        self.c_user?.setObject(file.url, forKey: "avatar")
                        self.c_user?.setObject(file.objectId, forKey: "avatarId")
                        self.c_user?.saveInBackground()
                        self.tableView.reloadData()
                    }else {
                        let errors = error! as NSError
                        print(errors)
                    }
                }
            }else {
                Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
            }
        }else {
            bgPic = image
            if (reachability?.isReachable)! {
                let imageData = UIImageJPEGRepresentation(image, 0.5)
                let file = AVFile.init(name: "bgPicture.jpg", data: imageData!)
                file.saveInBackground { (succeeded, error) in
                    if succeeded {
                        if let avatarId = self.c_user?.value(forKey: "bgPictureId") {
                            let oldAvatarFile = AVFile()
                            oldAvatarFile.objectId = avatarId as? String
                            oldAvatarFile.deleteInBackground({ (succeeded, error) in
                                if succeeded {
                                    print("成功！")
                                }else {
                                    let errors = error! as NSError
                                    print(errors)
                                }
                            })
                        }
                        self.c_user?.setObject(file.url, forKey: "bgPicture")
                        self.c_user?.setObject(file.objectId, forKey: "bgPictureId")
                        self.c_user?.saveInBackground()
                        self.tableView.reloadData()
                    }else {
                        let errors = error! as NSError
                        print(errors)
                    }
                }
            }else {
                Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
            }
        }
        
        picker.dismiss(animated: true, completion: { () -> Void in
            if picker.sourceType == .camera {
                let originalImage = info[UIImagePickerControllerOriginalImage]
                UIImageWriteToSavedPhotosAlbum(originalImage as! UIImage, self, nil, nil)
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func authorize() -> Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            // 请求授权
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    _ = self.authorize()
                })
            })
        default:
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: "照片访问受限", message: "点击“设置”，允许访问您的照片", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
                let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                    (action) -> Void in
                    let url = URL(string: UIApplicationOpenSettingsURLString)
                    if let url = url, UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10, *) {
                            UIApplication.shared.open(url, options: [:],completionHandler: {
                                (success) in
                            })
                        }else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                })
                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        return false
    }
    
    // 日期选择
    func chooseDate(picker: MoPicker, date: Date) {
        if (reachability?.isReachable)! {
            let dateString = date.string_from(formatter: "yyyy-MM-dd")
            c_user?.setObject(dateString, forKey: "birthday")
            c_user?.saveInBackground()
            tableView.reloadData()
        }else {
            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
        }
    }
    
    // 地区选择
    func chooseElements(picker: MoPicker, content: [Int : Int]) {
        var area:String = ""
        if let array = picker.contentArray {
            var tempArray = array
            for i in 0..<content.keys.count {
                let value:Int! = content[i]
                if value < tempArray.count {
                    let obj:MoPickerObject = tempArray[value]
                    let title = obj.title ?? ""
                    if area.characters.count>0 {
                        area = area.appending("-\(title)")
                    }else {
                        area = title;
                    }
                    if let arr = obj.subArray {
                        tempArray = arr
                    }
                }
            }
        if (reachability?.isReachable)! {
            c_user?.setObject(area, forKey: "area")
            c_user?.saveInBackground()
            tableView.reloadData()
        }else {
            Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
        }
        }
    }
    
    //创建导航栏
    func createNavBar() {
        navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar?.isTranslucent = false
        navBar?.py_add(toThemeColorPool: "barTintColor")
        navBar?.tintColor = UIColor.white
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.pushItem(createBarItem(), animated: true)
        self.view.addSubview(navBar!)
    }
    //设置导航栏左右按钮、标题
    func createBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToMe))
        navigationItem.title = "个人资料"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    //返回“我”页面
    func backToMe() {
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
