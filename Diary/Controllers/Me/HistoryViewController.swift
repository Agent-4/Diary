//
//  HistoryViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/01.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud

class HistoryViewController: UIViewController {
    
    var HistoryNavigationBar: UINavigationBar?
    fileprivate var now_user = AVUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createSettingNavigationBar()
        
        let diary1 = AVQuery.init(className: "Diary")
        diary1.whereKey("creater", equalTo: (self.now_user?.username)!)
        diary1.whereKey("diaryDate", greaterThan: Date())
        diary1.cachePolicy = .networkElseCache
        diary1.maxCacheAge = 72 * 3600
        let value1 = diary1.countObjects()
        
        
        let diary2 = AVQuery.init(className: "Diary")
        diary2.whereKey("creater", equalTo: (self.now_user?.username)!)
        diary2.whereKey("diaryDate", lessThan: Date())
        diary2.cachePolicy = .networkElseCache
        diary2.maxCacheAge = 72 * 3600
        let value2 = diary2.countObjects()
        
        if value2 == 0 {
            if value1 == 0 {
                let alertController = UIAlertController(title: "", message: "没有日记记录，快去写日记吧！", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                    self.backToMe()
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let item1 = PNPieChartDataItem(dateValue: CGFloat(value1), dateColor:MOLightGreen, description: "未来日记")
                let item2 = PNPieChartDataItem(dateValue: CGFloat(value2), dateColor: MOFreshGreen, description: "普通日记")
                
                let frame = CGRect(x: 30.0, y: 155.0, width: self.view.frame.width - 60.0, height: self.view.frame.width - 60.0)
                let items: [PNPieChartDataItem] = [item1, item2]
                let pieChart = PNPieChart(frame: frame, items: items)
                pieChart.descriptionTextColor = UIColor.white
                pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 13.0)!
                pieChart.showAbsoluteValues = true
                pieChart.center = self.view.center
                
                self.view.addSubview(pieChart)
            }
        }else {
            let item1 = PNPieChartDataItem(dateValue: CGFloat(value1), dateColor:MOLightGreen, description: "未来日记")
            let item2 = PNPieChartDataItem(dateValue: CGFloat(value2), dateColor: MOFreshGreen, description: "普通日记")
            
            let frame = CGRect(x: 30.0, y: 155.0, width: self.view.frame.width - 60.0, height: self.view.frame.width - 60.0)
            let items: [PNPieChartDataItem] = [item1, item2]
            let pieChart = PNPieChart(frame: frame, items: items)
            pieChart.descriptionTextColor = UIColor.white
            pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 13.0)!
            pieChart.showAbsoluteValues = true
            pieChart.center = self.view.center
            
            self.view.addSubview(pieChart)
        }
        
        let info = UILabel.init(frame: CGRect(x: (self.view.frame.width)/2 - 100, y: self.view.frame.height - 36.0, width: 200, height: 21))
        info.text = "每一条日记都有它特殊的意义!"
        info.textColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
        info.textAlignment = .center
        info.font = UIFont.systemFont(ofSize: 13.0)
        self.view.addSubview(info)
    }
    
    //创建导航栏
    func createSettingNavigationBar() {
        HistoryNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        HistoryNavigationBar?.isTranslucent = false
        HistoryNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        HistoryNavigationBar?.tintColor = UIColor.white
        HistoryNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        HistoryNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        HistoryNavigationBar?.shadowImage = UIImage()
        HistoryNavigationBar?.pushItem(createSettingBarItem(), animated: true)
        self.view.addSubview(HistoryNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func createSettingBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(HistoryViewController.backToMe))
        navigationItem.title = "历史"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: false)
        return navigationItem
    }
    //返回“我的”页面
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
