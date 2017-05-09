//
//  DiscoverViewController.swift
//  Diary
//
//  Created by moxiaohao on 16/9/30.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit
import AVOSCloud
import Kingfisher

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, photoPreviewDelegate {
    
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    var tableView: UITableView?
    var rowSize:CGSize?
    
    fileprivate var c_user = AVUser.current()
    fileprivate var diaryCount:Int?
    
    fileprivate var shareDiaryResult:[Any]?
    
    fileprivate var limitNum: Int = 20
    
    var theLikeNumber:Int = 0
    
    var bbannerView: BBannerView!
    
    var banner: BBannerView = {
        let banner1 = BBannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 90))
        return banner1
    }()
    var images = ["share1.png", "share2.png", "share3.png"]
    
//    var imageView: UIImageView?
    fileprivate var header = MJRefreshNormalHeader()
    fileprivate var footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        fillView.py_add(toThemeColorPool: "backgroundColor")
        navBar.py_add(toThemeColorPool: "barTintColor")
        
        updateShareDiary()
        
        rowSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: 160)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.bounds.height - 112), style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
//        tableView?.contentInset = UIEdgeInsetsMake(0, 0, 108, 0)
        tableView?.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1)
        tableView?.separatorStyle = .none
//        tableView?.rowHeight = UITableViewAutomaticDimension
//        tableView?.estimatedRowHeight = 160
//        tableView!.register(UINib(nibName:"DiscoverTableViewCell", bundle:nil), forCellReuseIdentifier:"discoverCell")
        tableView?.register(DiscoverDiaryTableViewCell.self, forCellReuseIdentifier: "discoverCell")
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
        
    }
    
    func updateShareDiary() {
        
        //        DispatchQueue.global().async {
        let shareDiary = AVQuery.init(className: "Diary")
        shareDiary.whereKey("share", equalTo: true)
        shareDiary.whereKey("diaryDate", lessThan: Date())
        shareDiary.cachePolicy = .networkElseCache
        shareDiary.maxCacheAge = 72 * 3600
        shareDiary.limit = limitNum
        shareDiary.order(byDescending: "diaryDate")
        //            self.diaryCount = self.shareDiary.countObjects()
        shareDiary.findObjectsInBackground({ (objects, error) in
            if objects != nil {
                self.shareDiaryResult = objects
                print("//////////////////////////////////////开始")
                print(self.shareDiaryResult!)
                print("//////////////////////////////////////结束")
                self.diaryCount = shareDiary.countObjects()
                self.tableView?.reloadData()
            }
        })
        //            DispatchQueue.main.async {
        //                self.tableView?.reloadData()
        //            }
        //        }
    }
    
    func headerRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.updateShareDiary()
            self.tableView?.mj_header.endRefreshing()
            Drop.down("刷新成功！", state: .color(#colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)), duration: 1.0)
            
        }
    }
    func footerRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.limitNum += 10
            self.updateShareDiary()
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
            return diaryCount!
        }
    }
    //返回行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return (rowSize?.height)!
        
    }
    //每组的头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
    //每组的底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 249/255, alpha: 1)
        banner.numberOfItems = { (bannerView: BBannerView) -> Int in
            return self.images.count
        }
        banner.viewForItem = { (bannerView: BBannerView, index: Int) -> UIView in
            let imageView = UIImageView(frame: bannerView.bounds)
            imageView.image = UIImage(named: self.images[index])
            return imageView
        }
        banner.reloadData()
        banner.startAutoScroll(timeIntrval: 6)
        headerView.addSubview(banner)
        
        return headerView
    }
    
    
    //cell数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:DiscoverTableViewCell = tableView.dequeueReusableCell(withIdentifier: "discoverCell") as! DiscoverTableViewCell
        let cell = DiscoverDiaryTableViewCell.init(style: .default, reuseIdentifier: "discoverCell")
        cell.selectionStyle = .none
        
        let result = shareDiaryResult?[indexPath.row] as! AVObject
        print(result)
        let userName = result.value(forKey: "creater") as? String
        let userQuery = AVQuery.init(className: "_User")
        userQuery.whereKey("username", equalTo: userName!)
        userQuery.findObjectsInBackground { (object, error) in
            if object != nil {
                let user = object?[0] as! AVObject
                cell.user_name.text = user.value(forKey: "nickName") as? String
                let avatarUrl = user.value(forKey: "avatar") as? String
                let url = URL(string: avatarUrl!)
                cell.user_avatar.kf.setImage(with: url)
            }else {
                let errors = error! as NSError
                print(errors)
            }
        }
        let content = result.value(forKey: "content") as? String
        let size = stringSize(content!, widthOfFatherView: self.view.frame.size.width - 45 , textFont: UIFont.systemFont(ofSize: 14))
        
        cell.diary_content.frame.size.height = size.height
        cell.diary_content.text = content
        
        let imageUrl = result.value(forKey: "imageUrl") as? String
        let imageWidth = UIScreen.main.bounds.size.width - 50
        if imageUrl == "" {
            rowSize?.height = size.height + 105
            cell.diary_view.frame.size.height = size.height + 95
            cell.diaryDate.frame.origin.y = 69 + size.height
            cell.likeNumber.frame.origin.y = 69 + size.height
            cell.likeBtn.frame.origin.y = 63 + size.height
        }else {
            rowSize?.height = size.height + imageWidth + 115
            cell.diary_view.frame.size.height = size.height + imageWidth + 105
            cell.diaryDate.frame.origin.y = 79 + size.height + imageWidth
            cell.likeNumber.frame.origin.y = 79 + size.height + imageWidth
            cell.likeBtn.frame.origin.y = 73 + size.height + imageWidth
            let imageView = UIImageView(frame: CGRect(x: 30, y: 65 + size.height, width: imageWidth, height: imageWidth))
            let url = URL(string: imageUrl!)
            imageView.kf.setImage(with: url)
            imageView.tag = indexPath.row
            imageView.isUserInteractionEnabled = true
            let imgTap = UITapGestureRecognizer.init(target: self, action: #selector(imageTap(tap:)))
            imageView.addGestureRecognizer(imgTap)
            cell.addSubview(imageView)
        }
        
        let date = result.value(forKey: "diaryDate") as? Date
        let dateStr = date?.string_from(formatter: "HH:mm yyyy-MM-dd")
        
        cell.diaryDate.text = dateStr
        theLikeNumber = (result.value(forKey: "like") as? Int)!
        cell.likeNumber.text = String(theLikeNumber)
        
        let diaryId = result.value(forKey: "objectId") as? String
        let userId = c_user?.objectId
        let likeQuery = AVQuery.init(className: "Likes")
        likeQuery.whereKey("diaryId", equalTo: diaryId!)
        likeQuery.whereKey("userId", equalTo: userId!)
        likeQuery.findObjectsInBackground { (like, error) in
            if like?.count != 0 {
                cell.likeBtn.isEnabled = false
                cell.likeBtn.setImage(UIImage(named: "likeSelected.png"), for: .normal)
            }else {
                cell.likeBtn.isEnabled = true
                cell.likeBtn.setImage(UIImage(named: "like.png"), for: .normal)
            }
        }
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeClicked(index:)), for: .touchUpInside)
        
        //修改cell选中的背景色
        cell.selectedBackgroundView = UIView.init()
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        return cell
    }
    
    func imageTap(tap: UITapGestureRecognizer) {
        let photoView = MOPhotoPreviewer()
        photoView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        photoView.preview(fromImageView: tap.view as! UIImageView, container: self.view)
    }
    
    // photoView 委托
    func viewSetting() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // 点赞操作
    func likeClicked(index: UIButton) {
        print("点击了 like \(index.tag)")
        index.isEnabled = false
//        theLikeNumber += 1
        
        let theResult = shareDiaryResult?[index.tag] as! AVObject
        let diaryId = theResult.value(forKey: "objectId") as? String
        let likeNum: Int = theResult.value(forKey: "like") as! Int
        
        let like = AVObject(className: "Likes")
        like.setObject(diaryId, forKey: "diaryId")
        like.setObject(c_user?.objectId, forKey: "userId")
        like.saveInBackground { (succeeded, error) in
            if succeeded {
                let diary = AVObject.init(className: "Diary", objectId: diaryId!)
                diary.setObject(likeNum + 1, forKey: "like")
                diary.saveInBackground({ (yes, error) in
                    if yes {
                        self.updateShareDiary()
//                        self.tableView?.beginUpdates()
                    }
                })
            }else {
                let errors = error! as NSError
                print(errors)
            }
        }
        
        index.setImage(UIImage(named: "likeSelected.png"), for: .normal)
        
    }
    
    func stringSize(_ contentString: String, widthOfFatherView: CGFloat, textFont: UIFont) -> CGSize {
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundingRect = contentString.boundingRect(with: CGSize(width: widthOfFatherView, height: 0), options: option, attributes: [NSFontAttributeName:textFont],context: nil)
        let size = boundingRect.size
        return size
    }
    
    
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
