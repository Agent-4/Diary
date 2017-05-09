//
//  SearchDiaryViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/15.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class SearchDiaryViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var diarySearchBar: UISearchBar!
    fileprivate var c_user = AVUser.current()
    var tableView: UITableView?
    var diaryCount:Int = 0
    var diaryResult:[Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.py_add(toThemeColorPool: "backgroundColor")
        navBar.py_add(toThemeColorPool: "barTintColor")
        diarySearchBar.delegate = self
        
        tableView = UITableView(frame: CGRect(x: 0, y: 108, width: self.view.frame.width, height: view.bounds.height - 108), style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self;
        //        tableView?.contentInset = UIEdgeInsetsMake(0, 0, 108, 0)
        tableView?.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1)
        tableView?.separatorStyle = .none
//        tableView!.register(UINib(nibName:"DiaryTableViewCell", bundle:nil), forCellReuseIdentifier:"diaryCell")
        tableView?.register(DiaryViewCell.self, forCellReuseIdentifier: "diaryCell")
        self.view.addSubview(tableView!)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        diarySearchBar.resignFirstResponder()
    }
    
//    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//        // 没有搜索内容时显示全部组件
//        if searchText == "" {
//            
//        }
//        else { // 匹配用户输入内容的前缀(不区分大小写)
//            
//        }
//        // 刷新Table View显示
////        self.tableView.reloadData()
//    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        diarySearchBar.resignFirstResponder()
        let qq = AVQuery.init(className: "Diary")
        qq.whereKey("creater", equalTo: (c_user?.username)!)
        qq.whereKey("content", contains: diarySearchBar.text!)
        qq.whereKey("diaryDate", lessThan: Date())
        qq.cachePolicy = .networkElseCache
        qq.maxCacheAge = 72 * 3600
        qq.order(byDescending: "diaryDate")
        diaryCount = qq.countObjects()
        qq.findObjectsInBackground({ (objects4, error) in
            if objects4 != nil {
                self.diaryResult = objects4
                print("//////////////////////////////////////")
                print(self.diaryResult!)
                print("//////////////////////////////////////")
                self.tableView?.reloadData()
            }
        })
        
        if diaryCount == 0 {
            Drop.down("没有找到包含'\(diarySearchBar.text!)'的日记！", state: .color(red), duration: 1.4)
        }
        
    }
    
    //table组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryCount
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
        let cell = DiaryViewCell(style: .default, reuseIdentifier: identifier)
        
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
    
    
    @IBAction func backToHome(_ sender: Any) {
        diarySearchBar.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    
    //收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        diarySearchBar.resignFirstResponder()
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
