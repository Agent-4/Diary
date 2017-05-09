//
//  DiaryDetailsViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/02.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud
import Kingfisher

class DiaryDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    var DiaryDetailsNavigationBar: UINavigationBar?
    var tableView: UITableView?
    var rowSize:CGSize?
    
    var diaryId:String?
    var diary_date:Date?
    var weather:Int?
    var mood:Int?
    var diary_content:String?
    var diary_imgUrl:String?
    
    var dateStr: String?
    var dateBtn: UIButton?
    var weatherBtn: UIButton?
    var moodBtn: UIButton?
    
    var textView: UITextView?
    var imageView: UIImageView?
    
    var updateButton: UIButton?
    
    var num:Int?
    let WIDTH = UIScreen.main.bounds.size.width
    
    fileprivate var isUpdate = false
    
    var _tencentOAuth:TencentOAuth!
    
    var qqShare: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _tencentOAuth = TencentOAuth.init(appId: "1106065929", andDelegate: nil)
        

        self.view.backgroundColor = UIColor.white
        
        print(weather!)
        print(mood!)
        print(diary_content!)
        print(diary_imgUrl!)
        print(diary_date!)
        
        if diary_imgUrl == "" {
            num = 1
        }else {
            num = 2
        }
        
        rowSize = CGSize.init(width: WIDTH, height: 160)
        
        textView = UITextView(frame: CGRect(x: 10, y: 0, width: WIDTH - 15, height: (rowSize?.height)!))
        textView?.delegate = self
        textView?.backgroundColor = UIColor.white
        textView?.textColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        textView?.font = UIFont.systemFont(ofSize: 15)
        textView?.tintColor = green
        textView?.isScrollEnabled = false
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: view.bounds.height), style: .grouped)
        let tvc = UITableViewController.init(style: .grouped)
        tableView = tvc.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        tableView?.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1)
        tableView?.separatorStyle = .none
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 160
        self.view.addSubview(tableView!)
        self.addChildViewController(tvc)
        
        createSettingNavigationBar()
    }
    
    // textView 改变后
    func textViewDidChange(_ textView: UITextView) {
        let str = textView.text
        rowSize = stringSize(str!, widthOfFatherView: WIDTH - 20 , textFont: UIFont.systemFont(ofSize: 15))
        textView.frame.size.height = (rowSize?.height)! + 30
        
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return num!
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return (rowSize?.height)! + 30
        }else {
            return WIDTH - 15
        }
        
        
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 46
        }else {
            return 0.1
        }
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0 {
            headerView.backgroundColor = UIColor.white
            dateBtn = UIButton(frame: CGRect(x: 11, y: 7, width: 85, height: 36))
            dateStr = diary_date?.string_from(formatter: "yyyy-MM-dd")
            dateBtn?.setTitle(dateStr, for: .normal)
            dateBtn?.setTitleColor(UIColor.gray, for: .normal)
            dateBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//            dateBtn?.addTarget(self, action: #selector(setDate), for: .touchUpInside)
            
            weatherBtn = UIButton(frame: CGRect(x: 105, y: 11, width: 30, height: 30))
            weatherBtn?.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
//            weatherBtn?.isEnabled = false
//            weatherBtn?.addTarget(self, action: #selector(goToSetWeatherAndMood), for: .touchUpInside)
            
            moodBtn = UIButton(frame: CGRect(x: 140, y: 8, width: 36, height: 36))
            moodBtn?.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
//            moodBtn?.isEnabled = false
//            moodBtn?.addTarget(self, action: #selector(goToSetWeatherAndMood), for: .touchUpInside)
            
            qqShare = UIButton(frame: CGRect(x: WIDTH - 45, y: 7, width: 40, height: 40))
            qqShare?.setImage(UIImage(named: "qqshare.png"), for: .normal)
            qqShare?.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12)
            qqShare?.isEnabled = true
            qqShare?.addTarget(self, action: #selector(shareToQQ), for: .touchUpInside)
            // 天气
            switch weather! {
                case 0: weatherBtn?.setImage(UIImage(named: "sun.png"), for: .normal)
                case 1: weatherBtn?.setImage(UIImage(named: "cloud.png"), for: .normal)
                case 2: weatherBtn?.setImage(UIImage(named: "wind.png"), for: .normal)
                case 3: weatherBtn?.setImage(UIImage(named: "drizzle.png"), for: .normal)
                case 4: weatherBtn?.setImage(UIImage(named: "rain.png"), for: .normal)
                case 5: weatherBtn?.setImage(UIImage(named: "lightning.png"), for: .normal)
                case 6: weatherBtn?.setImage(UIImage(named: "snow.png"), for: .normal)
                case 7: weatherBtn?.setImage(UIImage(named: "fog.png"), for: .normal)
                default: weatherBtn?.setImage(UIImage(named: "sun.png"), for: .normal)
            }
            // 心情
            switch mood! {
                case 0: moodBtn?.setImage(UIImage(named: "happy.png"), for: .normal)
                case 1: moodBtn?.setImage(UIImage(named: "neutral.png"), for: .normal)
                case 2: moodBtn?.setImage(UIImage(named: "veryHappy.png"), for: .normal)
                case 3: moodBtn?.setImage(UIImage(named: "cool.png"), for: .normal)
                case 4: moodBtn?.setImage(UIImage(named: "unhappy.png"), for: .normal)
                case 5: moodBtn?.setImage(UIImage(named: "wondering.png"), for: .normal)
                case 6: moodBtn?.setImage(UIImage(named: "sad.png"), for: .normal)
                case 7: moodBtn?.setImage(UIImage(named: "angry.png"), for: .normal)
                default: moodBtn?.setImage(UIImage(named: "happy.png"), for: .normal)
            }
            headerView.addSubview(dateBtn!)
            headerView.addSubview(weatherBtn!)
            headerView.addSubview(moodBtn!)
            headerView.addSubview(qqShare!)
        }else {
            //
        }
        return headerView
    }
    
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "diaryDetailsCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        cell?.selectionStyle = .none
        if indexPath.section == 0 {
            rowSize = stringSize(diary_content!, widthOfFatherView: self.view.frame.size.width - 20 , textFont: UIFont.systemFont(ofSize: 15))
            textView?.frame.size.height = (rowSize?.height)! + 30
            textView?.text = diary_content
            textView?.isEditable = false
            cell?.addSubview(textView!)
        }else {
            imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: self.view.frame.width - 30, height: self.view.frame.width - 30))
            let url = URL(string: diary_imgUrl!)
            imageView?.kf.setImage(with: url)
            imageView?.isUserInteractionEnabled = true
            let imgTap = UITapGestureRecognizer.init(target: self, action: #selector(diaryImgTap))
            imageView?.addGestureRecognizer(imgTap)
            cell?.addSubview(imageView!)
        }
        
        return cell!
    }
    
    
    func shareToQQ() {
//        let txtObj = QQApiTextObject(text: diary_content)
//        let req = SendMessageToQQReq.init(content: txtObj)
//        //发送并获取响应结果
//        let sendResult = QQApiInterface.send(req)
//        
//        //处理结果
//        handleSendResult(sendResult:  sendResult)
        let newsUrl = URL(string: "http://www.moxiaohao.com")
        let title = "我的 留忆 日记"
        let description = diary_content
        let previewImageUrl = URL(string: diary_imgUrl!)
        let newsObj = QQApiNewsObject(url: newsUrl, title: title, description: description,
                                      previewImageURL: previewImageUrl,
                                      targetContentType: QQApiURLTargetTypeNews)
        let req = SendMessageToQQReq(content: newsObj)
        QQApiInterface.send(req)
    }
    
    //处理分享返回结果
    func handleSendResult(sendResult:QQApiSendResultCode){
        var message = ""
        switch(sendResult){
        case EQQAPIAPPNOTREGISTED:
            message = "App未注册"
        case EQQAPIMESSAGECONTENTINVALID, EQQAPIMESSAGECONTENTNULL,
             EQQAPIMESSAGETYPEINVALID:
            message = "发送参数错误"
        case EQQAPIQQNOTINSTALLED:
            message = "QQ未安装"
        case EQQAPIQQNOTSUPPORTAPI:
            message = "API接口不支持"
        case EQQAPISENDFAILD:
            message = "发送失败"
        case EQQAPIQZONENOTSUPPORTTEXT:
            message = "空间分享不支持纯文本分享，请使用图文分享"
        case EQQAPIQZONENOTSUPPORTIMAGE:
            message = "空间分享不支持纯图片分享，请使用图文分享"
        default:
            message = "发送成功"
            print(sendResult)
        }
        print(message)
    }
    
    func diaryImgTap() {
        let photoView = MOPhotoPreviewer()
        photoView.preview(fromImageView: imageView!, container: self.view)
    }
    
    func stringSize(_ contentString: String, widthOfFatherView: CGFloat, textFont: UIFont) -> CGSize {
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundingRect = contentString.boundingRect(with: CGSize(width: widthOfFatherView, height: 0), options: option, attributes: [NSFontAttributeName:textFont],context: nil)
        let size = boundingRect.size
        return size
    }
    
    //创建导航栏
    func createSettingNavigationBar() {
        DiaryDetailsNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        DiaryDetailsNavigationBar?.isTranslucent = false
        DiaryDetailsNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        DiaryDetailsNavigationBar?.tintColor = UIColor.white
        DiaryDetailsNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        DiaryDetailsNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        DiaryDetailsNavigationBar?.shadowImage = UIImage()
        DiaryDetailsNavigationBar?.pushItem(createSettingBarItem(), animated: true)
        self.view.addSubview(DiaryDetailsNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func createSettingBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(DiaryDetailsViewController.backToHome))
        navigationItem.title = "日记详情"
        updateButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        updateButton?.setTitle("修改", for: .normal)
        updateButton?.setTitleColor(UIColor.white, for: .normal)
        updateButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        updateButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        updateButton?.addTarget(self, action: #selector(updateDiary), for: .touchUpInside)
        let rightBtn = UIBarButtonItem.init(customView: updateButton!)
        //用于消除右边空隙，要不然按钮顶不到最右
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -7;
        //设置导航项左右边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationItem.setRightBarButtonItems([spacer,rightBtn], animated: true)
        return navigationItem
    }
    
    //更新日记
    func updateDiary() {
        if isUpdate {
            if textView?.text == diary_content {
                Drop.down("日记内容没有任何修改！", state: .color(red), duration: 2)
            }else {
                let string = textView?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                if string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
                    Drop.down("日记内容不能为空！", state: .color(red), duration: 2)
                }else {
                    let reachability = Reachability.init()
                    if (reachability?.isReachable)! {
                        textView?.resignFirstResponder()
                        isUpdate = false
                        updateButton?.isEnabled = false
                        let diary = AVObject.init(className: "Diary", objectId: diaryId!)
                        diary.setObject(textView?.text, forKey: "content")
                        diary.saveInBackground({ (yes, error) in
                            if yes {
                                let notificationName = Notification.Name(rawValue: "UpdateDiaryNotification")
                                NotificationCenter.default.post(name: notificationName, object: nil)
                                Drop.down("修改成功！", state: .color(green), duration: 1.4)
                                Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.backToHome), userInfo: nil, repeats: false)
                            }
                        })
                    }else {
                        Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
                    }
                }
            }
        }else {
            qqShare?.isEnabled = false
            qqShare?.isHidden = true
            updateButton?.setTitle("完成", for: .normal)
            textView?.isEditable = true
            textView?.becomeFirstResponder()
            print("修改！！！！！！！！！！！！！")
            isUpdate = true
            imageView?.isUserInteractionEnabled = false
        }
    }
    
    //返回“主页”页面
    func backToHome() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView?.resignFirstResponder()
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
