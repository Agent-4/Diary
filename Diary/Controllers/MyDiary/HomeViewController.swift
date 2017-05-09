//
//  HomeViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/27.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
//import RealmSwift
import AVOSCloud
import Kingfisher

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    fileprivate var c_user = AVUser.current()
    
    var tableView: UITableView?
    fileprivate let qq = AVQuery.init(className: "Diary")
    
//    var diaryItems:Results<DiaryContent>?
    
    fileprivate var diaryResult:[Any]?
    fileprivate var diaryCount:Int?
    fileprivate var limitNum: Int = 40
    
    fileprivate var header = MJRefreshNormalHeader()
    fileprivate var footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        self.view.backgroundColor = UIColor.white
        
        self.tabBarController?.tabBar.py_add(toThemeColorPool: "tintColor")
        fillView.py_add(toThemeColorPool: "backgroundColor")
        navBar.py_add(toThemeColorPool: "barTintColor")
        setTabbarShadow()
        UserThemeColor.setColor()
        
        self.qq.whereKey("creater", equalTo: (self.c_user?.username)!)
        self.qq.whereKey("diaryDate", lessThan: Date())
        self.qq.cachePolicy = .networkElseCache
        self.qq.maxCacheAge = 72 * 3600
        self.qq.limit = limitNum
        self.qq.order(byDescending: "diaryDate")
        self.qq.findObjectsInBackground({ (objects4, error) in
            if objects4 != nil {
                self.diaryResult = objects4
                print("//////////////////////////////////////")
                print(self.diaryResult!)
                print("//////////////////////////////////////")
                self.diaryCount = self.qq.countObjects()
                self.tableView?.reloadData()
            }
        })
        
//        DispatchQueue.global().async {
//            
//            DispatchQueue.main.async {
//                self.tableView?.reloadData()
//            }
//        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 112), style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self;
//        tableView?.contentInset = UIEdgeInsetsMake(0, 0, 108, 0)
        tableView?.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1)
        tableView?.separatorStyle = .none
//        tableView?.register(UINib(nibName:"DiaryTableViewCell", bundle:nil), forCellReuseIdentifier:"diaryCell")
//        tableView?.register(DiaryTableViewCell.self, forCellReuseIdentifier: "diaryCell")
        tableView?.register(DiaryViewCell.self, forCellReuseIdentifier: "diaryCell")
        self.view.addSubview(tableView!)
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        header.lastUpdatedTimeLabel.isHidden = true
        header.setTitle("下拉刷新数据", for: .idle)
        header.setTitle("松开刷新数据", for: .pulling)
        header.setTitle("正在刷新数据", for: .refreshing)
        header.setTitle("刷新成功", for: .willRefresh)
        header.setTitle("刷新成功", for: .noMoreData)
        self.tableView?.mj_header = header
        
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("点击或上拉加载更多", for: .idle)
        footer.setTitle("松开加载数据", for: .pulling)
        footer.setTitle("正在加载数据", for: .refreshing)
        footer.setTitle("已全部加载完！", for: .noMoreData)
        self.tableView?.mj_footer = footer
        
        let notificationName = Notification.Name(rawValue: "UpdateDiaryNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(updateDiaryTableView), name: notificationName, object: nil)
        
    }
    
    func updateDiaryTableView() {
        self.qq.whereKey("creater", equalTo: (self.c_user?.username)!)
        self.qq.whereKey("diaryDate", lessThan: Date())
        self.qq.cachePolicy = .networkElseCache
        self.qq.maxCacheAge = 72 * 3600
        self.qq.limit = limitNum
        self.qq.order(byDescending: "diaryDate")
        self.qq.findObjectsInBackground({ (objects4, error) in
            if objects4 != nil {
                self.diaryResult = objects4
                print("//////////////////////////////////////")
                print(self.diaryResult!)
                print("//////////////////////////////////////")
                self.diaryCount = self.qq.countObjects()
                self.tableView?.reloadData()
            }
        })
    }
    
    @IBAction func goToWirteDiary(_ sender: Any) {
        let vc = WriteDiaryViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToCalendar(_ sender: Any) {
        let vc = CalendarViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func headerRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.updateDiaryTableView()
            self.tableView?.mj_header.endRefreshing()
            Drop.down("刷新成功！", state: .color(#colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)), duration: 1.0)
            
        }
    }
    func footerRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.limitNum += 10
            self.updateDiaryTableView()
            self.tableView?.mj_footer.endRefreshing()
            self.footer.endRefreshingWithNoMoreData()
            
        }
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if diaryCount == nil {
            return 0
        }else {
            return diaryCount!//diaryItems!.count
        }
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 110
        
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    //cell 加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "diaryCell"
//        let cell:DiaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! DiaryTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DiaryViewCell
//        if cell == nil{
        let cell = DiaryViewCell(style: .default, reuseIdentifier: identifier)
//            cell.selectionStyle = .none
//        }
    
//            self.qq.findObjectsInBackground({ (objects4, error) in
//                if objects4 != nil {
//                    let hh = objects4?[indexPath.row] as! AVObject
//                    let ff: NSMutableArray = objects4 as! NSMutableArray
        let hh = diaryResult?[indexPath.row] as! AVObject
        // 日
        cell.date_day.text = hh.value(forKey: "day") as? String
        // 年 月
        cell.date_year_month.text = hh.value(forKey: "year_month") as? String
        // 日记内容
        cell.diary_content.text = hh.value(forKey: "content") as? String
        
        let weatherSet:Int = (hh.value(forKey: "weather") as? Int)!
        let moodSet:Int = (hh.value(forKey: "mood") as? Int)!
        // 天气
        switch weatherSet {
            case 0: cell.weatherIcon.image = UIImage(named:"sun.png")
            case 1: cell.weatherIcon.image = UIImage(named:"cloud.png")
            case 2: cell.weatherIcon.image = UIImage(named:"wind.png")
            case 3: cell.weatherIcon.image = UIImage(named:"drizzle.png")
            case 4: cell.weatherIcon.image = UIImage(named:"rain.png")
            case 5: cell.weatherIcon.image = UIImage(named:"lightning.png")
            case 6: cell.weatherIcon.image = UIImage(named:"snow.png")
            case 7: cell.weatherIcon.image = UIImage(named:"fog.png")
            default: cell.weatherIcon.image = UIImage(named:"sun.png")
        }
        // 心情
        switch moodSet {
            case 0: cell.moodIcon.image = UIImage(named:"happy.png")
            case 1: cell.moodIcon.image = UIImage(named:"neutral.png")
            case 2: cell.moodIcon.image = UIImage(named:"veryHappy.png")
            case 3: cell.moodIcon.image = UIImage(named:"cool.png")
            case 4: cell.moodIcon.image = UIImage(named:"unhappy.png")
            case 5: cell.moodIcon.image = UIImage(named:"wondering.png")
            case 6: cell.moodIcon.image = UIImage(named:"sad.png")
            case 7: cell.moodIcon.image = UIImage(named:"angry.png")
            default: cell.weatherIcon.image = UIImage(named:"happy.png")
        }
        
        let imgUrl:String = (hh.value(forKey: "imageUrl") as? String)!
        if imgUrl == "" {
            cell.diary_content.frame = CGRect(x: 19, y: 37, width: self.view.frame.width - 40, height: 60)
            cell.diary_picture = UIImageView()
        }else {
            cell.diary_content.frame = CGRect(x: 19, y: 37, width: self.view.frame.width - 108, height: 60)
            let url = URL(string: imgUrl)
            // 日记图片
            cell.diary_picture.kf.setImage(with: url)
        }
        
        //修改cell选中的背景色
        cell.selectedBackgroundView = UIView.init()
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dd = diaryResult?[indexPath.row] as! AVObject
        let vc = DiaryDetailsViewController()
        vc.diaryId = dd.value(forKey: "objectId") as? String
        vc.diary_date = dd.value(forKey: "diaryDate") as? Date
        vc.weather = dd.value(forKey: "weather") as? Int
        vc.mood = dd.value(forKey: "mood") as? Int
        vc.diary_content = dd.value(forKey: "content") as? String
        vc.diary_imgUrl = dd.value(forKey: "imageUrl") as? String
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //滑动删除必须实现的方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        print("删除\(indexPath.row)")
        let alertController = UIAlertController(title: "", message: "你确定要删除此条日记！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
            self.deleteOneDiary(index: indexPath.row, indexPath: indexPath)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {(action) in
            self.tableView?.isEditing = false
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 删除某一条日记
    func deleteOneDiary(index: Int, indexPath: IndexPath) {
        self.qq.whereKey("creater", equalTo: (self.c_user?.username)!)
        self.qq.whereKey("diaryDate", lessThan: Date())
        self.qq.cachePolicy = .networkElseCache
        self.qq.maxCacheAge = 72 * 3600
        self.qq.order(byDescending: "diaryDate")
        self.qq.findObjectsInBackground({ (objects4, error) in
            if objects4 != nil {
                self.diaryResult = objects4
                let ff = objects4?[index] as! AVObject
                
                let imageId:String = ff.value(forKey: "imageId") as! String
                if imageId == "" {
                    //
                }else {
                    let diaryImageFile = AVFile()
                    diaryImageFile.objectId = imageId
                    diaryImageFile.deleteInBackground({ (succeeded, error) in
                        if succeeded {
                            print("成功删除日记图片！")
                        }else {
                            let errors = error! as NSError
                            print(errors)
                        }
                    })
                }
                
                print(ff.value(forKey: "objectId")!)
                let deleteID = ff
                deleteID.deleteEventually({ (objects, error) in
                    if error == nil {
                        print("删除完成！")
                        print(objects!)
                        self.diaryCount = self.qq.countObjects()
                        self.tableView?.deleteRows(at: [indexPath], with: .top)
                    }else {
                        self.diaryCount = self.qq.countObjects()
                        self.tableView?.deleteRows(at: [indexPath], with: .top)
                    }
                })
                //                    let id = (ff[indexPath.row] as AnyObject).value(forKey: "objectId")!
                //                    AVQuery.doCloudQueryInBackground(withCQL: "delete from Diary where objectId='\(id)'", callback: { (result, error) in
                //                        if error == nil {
                //                            print("删除完成！")
                //                            self.diaryCount = qq.countObjects()
                //                            self.tableView?.deleteRows(at: [indexPath], with: .top)
                //                        }else {
                //                            self.diaryCount = qq.countObjects()
                //                            self.tableView?.deleteRows(at: [indexPath], with: .top)
                //                        }
                //                    })
            }
        })
    }
    
    //滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCellEditingStyle {
            return UITableViewCellEditingStyle.delete
    }
    
    //修改删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    //去除tabbar顶部黑线，自定义设置tabBar分割线的样式,换成阴影
    func setTabbarShadow() {
        
        //去除tabbar顶部黑线,换成阴影
        self.tabBarController?.tabBar.shadowImage = UIImage(named: "tabbar_shadow")
        //必须要初始化tabbar背景图片
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        //设置tabbar背景颜色为白色
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
    }
    
    //设置statusBar颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("通知销毁完毕！！！！")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

