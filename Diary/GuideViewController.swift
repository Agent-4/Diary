//
//  GuideViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/10/12.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit


class GuideViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var startBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //引导页面 函数调用
        guideViewLayout()
        
    }
    
    //scrollview 委托
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = self.view.bounds
        let offset = scrollView.contentOffset
        
        pageControl.currentPage = Int(offset.x/frame.size.width)
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
    
    //载入自定义引导页面布局
    func guideViewLayout(){
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.contentSize = CGSize(width: 4 * frame.size.width, height: frame.size.height)
        
        for i in 1...4 {
            let image = UIImage(named: "GuideImage\(Int(i)).png")
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: CGFloat((i-1))*frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
            imageView.contentMode = UIViewContentMode.scaleToFill
            scrollView.addSubview(imageView)
            
        }
        
        pageControl = UIPageControl(frame: CGRect(x: frame.size.width/2-100, y: frame.size.height-80, width: 200, height: 100))
        startBtn = UIButton(frame: CGRect(x: frame.size.width/2-55, y: frame.size.height-100, width: 110, height: 35))
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        startBtn.setTitle("欢迎体验", for: UIControlState.normal)
        startBtn.backgroundColor = UIColor.orange
        // 给开始按钮设置圆角
        startBtn.layer.cornerRadius = 16.0
        startBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        startBtn.addTarget(self, action: #selector(GuideViewController.guideOver), for: UIControlEvents.touchUpInside)
        startBtn.alpha = 0.0
        
        
        scrollView.bounces=false
        scrollView.delegate=self
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        self.view.addSubview(startBtn)
        
    }
    
    //引导结束，开始使用app
    func guideOver(){
        let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = mainStoryboard.instantiateInitialViewController()
        self.present(viewController!, animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

