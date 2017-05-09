//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/11.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud
//import RealmSwift

private let identifierCell = "identifierCell"
private let maxPictureCount = 1

fileprivate let WIDTH = UIScreen.main.bounds.width

class WriteDiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate , weatherAndMoodDelegate, PickerDelegate, InfoViewDelegate {
    
    fileprivate var c_user = AVUser.current()
    var navBar: UINavigationBar?
    var tableView: UITableView!
    fileprivate var saveButton: UIButton?
    
    var diaryCreateAt: Date = Date()
    var dateStr: String?
    var dateBtn: UIButton?
    var weatherBtn: UIButton?
    var moodBtn: UIButton?
    var shareBtn: UIButton?
    
    var weatherSet: Int = 0
    var moodSet: Int = 0
    var shareSet = false
    
    fileprivate var diaryImage:UIImage?
    fileprivate var imageSet = false
    fileprivate var imageUrl = ""
    fileprivate var imageId = ""
    
    /// pictureView的数据源
    lazy var pictures: [UIImage] = []
    var selectedIndex: Int = 0
    
    var textView: UITextView?
    var placeholderLabel: UILabel?
    var size: CGSize?
    
    let reachability = Reachability.init()
    
    /// 选择图片的collectionView
    lazy var pictureView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), collectionViewLayout: ComposeImageLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MOComposeCell.self, forCellWithReuseIdentifier: identifierCell)
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let fillView = UIView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: 46))
        fillView.layer.opacity = 0.95
        fillView.layer.shadowColor = UIColor.lightGray.cgColor
        fillView.layer.shadowOffset = CGSize.init(width: 0, height: 0.5)
        fillView.layer.shadowOpacity = 0.1
        fillView.layer.shadowRadius = 1
        fillView.backgroundColor = UIColor.white
        
        dateBtn = UIButton(frame: CGRect(x: 11, y: 71, width: 85, height: 36))
        dateStr = Date().string_from(formatter: "yyyy-MM-dd")
        dateBtn?.setTitle(dateStr, for: .normal)
        dateBtn?.setTitleColor(UIColor.gray, for: .normal)
        dateBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        dateBtn?.setImage(UIImage(named: "date"), for: .normal)
//        dateBtn?.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        dateBtn?.addTarget(self, action: #selector(setDate), for: .touchUpInside)
        
        weatherBtn = UIButton(frame: CGRect(x: 105, y: 75, width: 30, height: 30))
        weatherBtn?.setImage(UIImage(named: "sun.png"), for: .normal)
        weatherBtn?.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
        weatherBtn?.addTarget(self, action: #selector(goToSetWeatherAndMood), for: .touchUpInside)
        
        moodBtn = UIButton(frame: CGRect(x: 140, y: 72, width: 36, height: 36))
        moodBtn?.setImage(UIImage(named: "happy.png"), for: .normal)
        moodBtn?.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        moodBtn?.addTarget(self, action: #selector(goToSetWeatherAndMood), for: .touchUpInside)
        
        shareBtn = UIButton(frame: CGRect(x: WIDTH - 45, y: 67, width: 40, height: 40))
        shareBtn?.setImage(UIImage(named: "social.png"), for: .normal)
        shareBtn?.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9)
        shareBtn?.addTarget(self, action: #selector(setShare), for: .touchUpInside)
        
        size = CGSize.init(width: WIDTH - 20, height: 80)
        textView = UITextView(frame: CGRect(x: 10, y: 0, width: WIDTH - 15, height: (size?.height)!))
        textView?.delegate = self
        textView?.backgroundColor = UIColor.white
        textView?.font = UIFont.systemFont(ofSize: 15)
        textView?.tintColor = green
        textView?.isEditable = true
        textView?.isScrollEnabled = false
        
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: view.bounds.height), style: .grouped)
        let tvc = UITableViewController.init(style: .grouped)
        tableView = tvc.tableView
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(75, 0, 0, 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        tableView.keyboardDismissMode = .onDrag
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.white
        self.view.addSubview(tableView)
        self.addChildViewController(tvc)
        
        createNavBar()
        self.view.addSubview(fillView)
        self.view.addSubview(dateBtn!)
        self.view.addSubview(weatherBtn!)
        self.view.addSubview(moodBtn!)
        self.view.addSubview(shareBtn!)
        
        // 占位符 用 Label 代替
        placeholderLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 222, height: 21))
        placeholderLabel?.text = "这一天过得好吗？"
        placeholderLabel?.textColor = UIColor.lightGray
        placeholderLabel?.font = UIFont.systemFont(ofSize: 14)
        textView?.addSubview(placeholderLabel!)
        
    }
    
    // WeatherAndMood 代理回调
    func setWeatherAndMood(weatherSelected: Int, moodSelected: Int) {
        // 天气
        switch weatherSelected {
        case 0:
            weatherBtn?.setImage(UIImage(named: "sunSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 1:
            weatherBtn?.setImage(UIImage(named: "cloudSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 2:
            weatherBtn?.setImage(UIImage(named: "windSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 3:
            weatherBtn?.setImage(UIImage(named: "drizzleSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 4:
            weatherBtn?.setImage(UIImage(named: "rainSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 5:
            weatherBtn?.setImage(UIImage(named: "lightningSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 6:
            weatherBtn?.setImage(UIImage(named: "snowSelected.png"), for: .normal)
            weatherSet = weatherSelected
        case 7:
            weatherBtn?.setImage(UIImage(named: "fogSelected.png"), for: .normal)
            weatherSet = weatherSelected
        default:
            break
        }
        // 心情
        switch moodSelected {
        case 0:
            moodBtn?.setImage(UIImage(named: "happySelected.png"), for: .normal)
            moodSet = moodSelected
        case 1:
            moodBtn?.setImage(UIImage(named: "neutralSelected.png"), for: .normal)
            moodSet = moodSelected
        case 2:
            moodBtn?.setImage(UIImage(named: "veryHappySelected.png"), for: .normal)
            moodSet = moodSelected
        case 3:
            moodBtn?.setImage(UIImage(named: "coolSelected.png"), for: .normal)
            moodSet = moodSelected
        case 4:
            moodBtn?.setImage(UIImage(named: "unhappySelected.png"), for: .normal)
            moodSet = moodSelected
        case 5:
            moodBtn?.setImage(UIImage(named: "wonderingSelected.png"), for: .normal)
            moodSet = moodSelected
        case 6:
            moodBtn?.setImage(UIImage(named: "sadSelected.png"), for: .normal)
            moodSet = moodSelected
        case 7:
            moodBtn?.setImage(UIImage(named: "angrySelected.png"), for: .normal)
            moodSet = moodSelected
        default:
            break
        }
    }
    
    func setDate() {
        textView?.resignFirstResponder()
        let picker = MoPicker.init(delegate: self, style: .date)
        picker.max_Date = Date.init(timeIntervalSinceNow: 126144000) // 初始最大日期 = now + 4年
        picker.min_Date = Date.init(timeIntervalSinceNow: -126144000) // 初始最小日期 = now - 4年
        picker.show()
    }
    
    func  chooseDate(picker: MoPicker, date: Date) {
        let dateString = date.string_from(formatter: "yyyy-MM-dd")
        dateBtn?.setTitle(dateString, for: .normal)
        diaryCreateAt = date
        print(dateString)
        let now = Date().string_from(formatter: "yyyy-MM-dd")
        if now.compare(dateString) == ComparisonResult.orderedAscending {
            placeholderLabel?.text = "你正在给未来的自己写一篇日记...."
        }else {
            placeholderLabel?.text = "这一天过得好吗？"
        }
        
    }
    
    func chooseElements(picker: MoPicker, content: [Int : Int]) {
        // 这里没有用到（但delegate要求设置）
    }
    
    func setShare() {
        textView?.resignFirstResponder()
        let alertController = UIAlertController(title: "", message: "保存日记时将同时分享到广场？", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "不分享", style: .destructive) { (actoin) in
            self.shareBtn?.setImage(UIImage(named: "social.png"), for: .normal)
            self.shareSet = false
        }
        let okAction = UIAlertAction(title: "确定", style: .default) { (actoin) in
            self.shareBtn?.setImage(UIImage(named: "socialSelected.png"), for: .normal)
            self.shareSet = true
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func goToSetWeatherAndMood() {
        textView?.resignFirstResponder()
        let WeatherAndMood_view = WeatherAndMoodView.createView(fromNibName: "WeatherAndMoodView")
        WeatherAndMood_view?.delegate = self
        WeatherAndMood_view?.layer.cornerRadius = 4
        WeatherAndMood_view?.layer.masksToBounds = true
        let WMAlertController = TYAlertController.init(alert: WeatherAndMood_view, preferredStyle: .alert)
        WMAlertController?.backgoundTapDismissEnable = false
        self.present(WMAlertController!, animated: true, completion: nil)
    }
    
    // textView 改变后
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = (self.textView?.text.lengthOfBytes(using: String.Encoding.utf8))! > 0
        
//        var bounds = textView.bounds
//        let maxSize = CGSize.init(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
//        let newSize = textView.sizeThatFits(maxSize)
//        bounds.size = newSize
//        textView.bounds = bounds
//        
//        let tableView = self.tableView
//        tableView?.beginUpdates()
//        tableView?.endUpdates()
        let str = textView.text
        size = stringSize(str!, widthOfFatherView: self.view.frame.size.width - 20 , textFont: UIFont.systemFont(ofSize: 15))
        //        let theIndexPath = IndexPath.init(row: 0, section: 0)
        if (size?.height)! < CGFloat(80) {
            size = CGSize(width: WIDTH - 15, height: 80)
            textView.frame.size.height = (size?.height)! + 30
        }else {
            textView.frame.size.height = (size?.height)! + 40
        }
//        let offY = tableView.contentOffset.y
//        if (size?.height)! > CGFloat(161) {
//            tableView.frame.origin.y = offY - ((size?.height)! - 161 - 110)
//        }else {
//            tableView.frame.origin.y = offY + 110
//        }
        
        print(size?.height as Any)
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            if (size?.height)! <= CGFloat(80) {
                return 115
            }else {
                return (size?.height)! + 42
            }
//            return 80
        }else {
            return 200
        }
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "writeDiaryCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        
        if indexPath.section == 0 {
            cell?.addSubview(textView!)
        }else {
            cell?.addSubview(pictureView)
        }
        var rect = textView?.frame
        rect?.size.height = (size?.height)! 
        textView?.frame = rect!
//        textView?.becomeFirstResponder()
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.white
        return cell!
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let str = textView.text
//        size = stringSize(str!, widthOfFatherView: self.view.frame.size.width - 20 , textFont: UIFont.systemFont(ofSize: 15))
////        let theIndexPath = IndexPath.init(row: 0, section: 0)
//        if (size?.height)! < CGFloat(80) {
//            size = CGSize.init(width: WIDTH - 20, height: 80)
//        }
//        print(size?.height as Any)
//        tableView.beginUpdates()
//        tableView.endUpdates()
//        return true
//    }
//
    func stringSize(_ contentString: String, widthOfFatherView: CGFloat, textFont: UIFont) -> CGSize {
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundingRect = contentString.boundingRect(with: CGSize(width: widthOfFatherView, height: 0), options: option, attributes: [NSFontAttributeName:textFont],context: nil)
        let size = boundingRect.size
        return size
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(back))
        navigationItem.title = "写日记"
        saveButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        saveButton?.setTitle("保存", for: .normal)
        saveButton?.setTitleColor(UIColor.white, for: .normal)
        saveButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .highlighted)
        saveButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveButton?.addTarget(self, action: #selector(saveDiaryInLeanCloud), for: .touchUpInside)
        let rightBtn = UIBarButtonItem.init(customView: saveButton!)
        //用于消除右边空隙，要不然按钮顶不到最右
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -7;
        //设置导航项左右边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationItem.setRightBarButtonItems([spacer,rightBtn], animated: true)
        return navigationItem
    }
    
//    func saveNewDiary() {
//        
//        textView?.resignFirstResponder()
//        if textView?.text != "" {
//            setDefaultRealmForUser(username: (c_user?.username)!)
//            
//            let realm = try! Realm()
////            let dd = realm.objects(DiaryContent.self)
//            
//            let new_Diary = DiaryContent()
//            new_Diary.createAt = diaryCreateAt
//            new_Diary.weather = weatherSet
//            new_Diary.mood = moodSet
//            new_Diary.content = (textView?.text)!
//            new_Diary.creater = (c_user?.username)!
//            new_Diary.share = shareSet
////            new_Diary.diary_id = dd.count
////            print(dd.count)
//            
//            try! realm.write {
//                realm.add(new_Diary)
//            }
//            
//            print(realm.configuration.fileURL!)
//            Drop.down("日记保存成功！", state: .color(green), duration: 1.4)
//            Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
//            
//        }else {
//            print("未填写内容！")
//            Drop.down("你还没有填写日记内容！", state: .color(red), duration: 2)
//        }
//        
//    }
    
    // LeanCloud 存储日记
    func saveDiaryInLeanCloud() {
        let string = textView?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if string?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            Drop.down("你还没有填写日记内容！", state: .color(red), duration: 2)
        }else {
            if (reachability?.isReachable)! {
                saveButton?.isEnabled = false
                if imageSet == true {
                    let imageData = UIImageJPEGRepresentation(diaryImage!, 0.8)
                    let file = AVFile.init(name: "diaryPicture.jpg", data: imageData!)
                    file.saveInBackground { (succeeded, error) in
                        if succeeded {
                            self.imageUrl = file.url!
                            self.imageId = file.objectId!
                            self.newDiary()
                        }else {
                            let errors = error! as NSError
                            print(errors)
                        }
                    }
                }else {
                    newDiary()
                }
            }else {
                Drop.down("网络连接不可用，请打开网络连接！", state: .color(red), duration: 2)
            }
        }
    }
    
    func newDiary() {
        let diary = AVObject(className: "Diary")
        if shareSet == true {
            diary.setObject(textView?.text, forKey: "content")
            diary.setObject(weatherSet, forKey: "weather")
            diary.setObject(moodSet, forKey: "mood")
            diary.setObject(c_user?.username, forKey: "creater")
            diary.setObject(shareSet, forKey: "share")
            diary.setObject(diaryCreateAt, forKey: "diaryDate")
            diary.setObject(diaryCreateAt.string_from(formatter: "dd"), forKey: "day")
            diary.setObject(diaryCreateAt.string_from(formatter: "yyyy-MM"), forKey: "year_month")
            diary.setObject(0, forKey: "like")
            diary.setObject(imageUrl, forKey: "imageUrl")
            diary.setObject(imageId, forKey: "imageId")
            diary.saveEventually({ (succeeded, error) in
                if succeeded {
                    Drop.down("日记保存成功！", state: .color(green), duration: 1.4)
                    let now = Date().string_from(formatter: "yyyy-MM-dd")
                    let date2 = self.diaryCreateAt.string_from(formatter: "yyyy-MM-dd")
                    if now.compare(date2) == ComparisonResult.orderedAscending {
                        self.theFutureDiaryInfoView()
                    }else {
                        let notificationName = Notification.Name(rawValue: "UpdateDiaryNotification")
                        NotificationCenter.default.post(name: notificationName, object: nil)
                        Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                    }
                }else {
                    let errors = error! as NSError
                    print(errors)
                }
            })
        }else {
            diary.setObject(textView?.text, forKey: "content")
            diary.setObject(weatherSet, forKey: "weather")
            diary.setObject(moodSet, forKey: "mood")
            diary.setObject(c_user?.username, forKey: "creater")
            diary.setObject(shareSet, forKey: "share")
            diary.setObject(diaryCreateAt, forKey: "diaryDate")
            diary.setObject(diaryCreateAt.string_from(formatter: "dd"), forKey: "day")
            diary.setObject(diaryCreateAt.string_from(formatter: "yyyy-MM"), forKey: "year_month")
            diary.setObject(imageUrl, forKey: "imageUrl")
            diary.setObject(imageId, forKey: "imageId")
            let acl = AVACL.init()
            acl.setReadAccess(true, for: AVUser.current()!)
            acl.setWriteAccess(true, for: AVUser.current()!)
            diary.acl = acl
            diary.saveEventually({ (succeeded, error) in
                if succeeded {
                    Drop.down("日记保存成功！", state: .color(green), duration: 1.4)
                    let now = Date().string_from(formatter: "yyyy-MM-dd")
                    let date2 = self.diaryCreateAt.string_from(formatter: "yyyy-MM-dd")
                    if now.compare(date2) == ComparisonResult.orderedAscending {
                        self.theFutureDiaryInfoView()
                    }else {
                        let notificationName = Notification.Name(rawValue: "UpdateDiaryNotification")
                        NotificationCenter.default.post(name: notificationName, object: nil)
                        Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.back), userInfo: nil, repeats: false)
                    }
                }else {
                    let errors = error! as NSError
                    print(errors)
                }
            })
        }
    }
    
    // 未来日记 提示信息
    func theFutureDiaryInfoView() {
        let infoView = FutureDiaryInfoView.createView(fromNibName: "FutureDiaryInfoView")
        infoView?.delegate = self
        infoView?.futureDate.text = diaryCreateAt.string_from(formatter: "yyyy-MM-dd")
        infoView?.layer.cornerRadius = 4
        infoView?.layer.masksToBounds = true
        let infoAC = TYAlertController.init(alert: infoView, preferredStyle: .alert)
        infoAC?.backgoundTapDismissEnable = false
        self.present(infoAC!, animated: true, completion: nil)
    }
    
    //返回上一级页面
    func back() {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // InfoViewDelegate
    func goBack() {
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

// MARK: - cell的layout
class ComposeImageLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: (WIDTH - 4 * 10) / 3 - 1, height: (WIDTH - 4 * 10) / 3 - 1)
        sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
    }
}

// MARK: - UICollectionViewDataSource
extension WriteDiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count < maxPictureCount ? pictures.count + 1 : maxPictureCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! MOComposeCell
        cell.delegate = self
        //如果是加号按钮传nil, 如果是图片的cell, 就传image
        //判断是否是加号
        if indexPath.row == pictures.count {
            cell.image = nil
        } else {
            cell.image = pictures[indexPath.row]
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
}

extension WriteDiaryViewController: MOComposeCellDelegate {
    func addOrChangePicture(cell: MOComposeCell) {
        //通过cell获取cell对应的index
        selectedIndex = (pictureView.indexPath(for: cell)?.item)!
        //1. 弹出imagePicker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// 删除图片
    /// - Parameter cell: 点击的cell
    func deletePicture(cell: MOComposeCell) {
        selectedIndex = (pictureView.indexPath(for: cell)?.item)!
        pictures.remove(at: selectedIndex)
        imageSet = false
        pictureView.reloadData()
    }
}

extension WriteDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //从相册中取出编辑后的方图
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        diaryImage = image
        imageSet = true
        //将方图压缩成小图
        let littleImage = image.wb_createImage(isCornored: false, size: CGSize(width: 80, height: 80))
        //使用小图
        //如果点击的是加号
        if selectedIndex == pictures.count {
            pictures.append(littleImage)
        } else {
            pictures[selectedIndex] = littleImage
        }
        //把图片选择的controller dismiss掉
        picker.dismiss(animated: true, completion: nil)
        
        //刷新CollectionView
        pictureView.reloadData()
    }
}


