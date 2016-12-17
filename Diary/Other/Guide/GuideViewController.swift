//
//  GuideViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/10/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        //引导页面 函数调用
        guideViewLayout()
    }
    
    //载入自定义引导页面布局
    func guideViewLayout(){
        let arr = ["GuideImage1.jpg", "GuideImage2.jpg", "GuideImage3.jpg", "GuideImage4.jpg"]
        let frameWidth = self.view.bounds.size.width
        let frameHeight = self.view.bounds.size.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: CGFloat(Float(arr.count)) * frameWidth, height: frameHeight)
        self.view.addSubview(scrollView)
        
        for i in 0 ..< arr.count {
            let index = CGFloat(Float(i))
            let imageView = UIImageView.init(frame: CGRect(x: index * frameWidth, y: 0, width: frameWidth, height: frameHeight))
            imageView.image = UIImage(named: arr[i])
            imageView.contentMode = UIViewContentMode.scaleToFill
            scrollView.addSubview(imageView)
            
            if i == arr.count - 1 {
                imageView.isUserInteractionEnabled = true
                startBtn = UIButton(frame: CGRect(x: frameWidth/2-55, y: frameHeight-100, width: 110, height: 35))
                startBtn.setTitle("欢迎体验", for: UIControlState.normal)
                startBtn.backgroundColor = UIColor.orange
                startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                // 给开始按钮设置圆角
                startBtn.layer.cornerRadius = 16.0
                startBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
                //按钮点击动作
                startBtn.addTarget(self, action: #selector(GuideViewController.guideOver), for: UIControlEvents.touchUpInside)
                imageView.addSubview(startBtn)
            }
        }
        if pageControl == nil {
            pageControl = UIPageControl(frame: CGRect(x: frameWidth/2-100, y: frameHeight-80, width: 200, height: 140))
            pageControl.numberOfPages = arr.count
            pageControl.pageIndicatorTintColor = UIColor.white
            pageControl.currentPageIndicatorTintColor = UIColor.orange
            self.view.addSubview(pageControl)
        }
    }
    
    //scrollview 委托 判断是否滑动到最后一张以显示"欢迎体验"按钮
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x / self.view.bounds.size.width
        pageControl.currentPage = Int(offSet)
        
        //按钮出现时的一点点特效
        if(pageControl.currentPage == 3) {
            UIView.animate(withDuration: 0.5) {
                self.startBtn.alpha = 1.0
            }
        }else{
            UIView.animate(withDuration: 0.2) {
                self.startBtn.alpha = 0.0
            }
        }
    }
    
    //引导结束，开始使用App
    func guideOver(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateInitialViewController()
        
        viewController?.modalTransitionStyle = .crossDissolve
        self.present(viewController!, animated: true, completion: nil)
    }
    
    //引导页面 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

