//
//  SettingSkinViewController.swift
//  Diary
//
//  Created by moxiaohao on 2017/3/23.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class SettingSkinViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var skinNavigationBar: UINavigationBar?
    var selectedIndex: Int?
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        createSkinNavigationBar()
        let layout = UICollectionViewFlowLayout();
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64), collectionViewLayout: layout)
        collectionView.register(SkinCollectionViewCell.self, forCellWithReuseIdentifier: "skinCell")
        collectionView.register(SkinCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "skinFooterView")
        collectionView.register(SkinCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "skinHeaderView")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = UIColor.white
        layout.itemSize = CGSize(width: (self.view.frame.width - 48)/2, height: (self.view.frame.width - 48)/4);
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsetsMake(24, 16, 4, 16)
        selectedIndex = userDefault.integer(forKey: "colorIndex")
        self.view.addSubview(collectionView)
    }
    
    //创建导航栏
    func createSkinNavigationBar() {
        skinNavigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        skinNavigationBar?.isTranslucent = false
        skinNavigationBar?.py_add(toThemeColorPool: "barTintColor")
        skinNavigationBar?.tintColor = UIColor.white
        skinNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]
        skinNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        skinNavigationBar?.shadowImage = UIImage()
        skinNavigationBar?.pushItem(createSkinBarItem(), animated: true)
        self.view.addSubview(skinNavigationBar!)
    }
    //设置导航栏左右按钮、标题
    func createSkinBarItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToSetting))
        navigationItem.title = "主题皮肤"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: false)
        return navigationItem
    }
    //返回“设置”页面
    func backToSetting() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取设计的单元格，不需要再动态添加界面元素
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skinCell", for: indexPath) as! SkinCollectionViewCell
        switch indexPath.row {
            case 0:
                cell.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.7333333333, blue: 0.4980392157, alpha: 1)
                cell.title?.text = "翠绿"
                if selectedIndex == 0 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            case 1:
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.3722903728, blue: 0.3634029031, alpha: 1)
                cell.title?.text = "粉红"
                if selectedIndex == 1 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            case 2:
                cell.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
                cell.title?.text = "兰紫"
                if selectedIndex == 2 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            case 3:
                cell.backgroundColor = #colorLiteral(red: 0, green: 0.6, blue: 1, alpha: 1)
                cell.title?.text = "湖蓝"
                if selectedIndex == 3 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            case 4:
                cell.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                cell.title?.text = "黝黑"
                if selectedIndex == 4 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            case 5:
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.4863265157, blue: 0, alpha: 1)
                cell.title?.text = "橘黄"
                if selectedIndex == 5 {
                    cell.selectImg?.image = UIImage(named: "select")
                }else {
                    cell.selectImg?.image = UIImage()
                }
            default: break
        }
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var skinReuseView: UICollectionReusableView!
        if kind == UICollectionElementKindSectionFooter {
            skinReuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "skinFooterView", for: indexPath)
            (skinReuseView as! SkinCollectionReusableView).footerTitle?.text = "选择一个你喜欢的颜色吧！(●'◡'●)ﾉ♥"
        }else {
            skinReuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "skinHeaderView", for: indexPath)
        }
        
        return skinReuseView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch indexPath.row {
            case 0:
                selectedIndex = 0
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 0.2274509804, green: 0.7333333333, blue: 0.4980392157, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            case 1:
                selectedIndex = 1
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 1, green: 0.3725490196, blue: 0.3647058824, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            case 2:
                selectedIndex = 2
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            case 3:
                selectedIndex = 3
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 0, green: 0.6, blue: 1, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            case 4:
                selectedIndex = 4
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            case 5:
                selectedIndex = 5
                collectionView.reloadData()
                self.py_setThemeColor(#colorLiteral(red: 1, green: 0.4863265157, blue: 0, alpha: 1))
                userDefault.set(selectedIndex, forKey: "colorIndex")
            default: break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.88
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.1, animations: {
            cell?.alpha = 1
        }, completion: nil)
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
