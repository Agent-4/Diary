//
//  TermsOfUserViewControllerViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/16.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit


class TermsOfUserViewController: UIViewController {
    
    var navBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(scrollView)
        let userTermsLabel = UILabel.init()
//        let txtUrl = Bundle.main.path(forResource: "Terms", ofType:"txt")!
//        let data = NSData(contentsOfFile: txtUrl)
//        let termsTxt = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//        print(termsTxt as Any)
        userTermsLabel.text = "隐私政策:\n\n'留忆'尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，'留忆'会按照本隐私权政策的规定使用和披露您的个人信息。但'留忆'将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，'留忆'不会将这些信息对外披露或向第三方提供。'留忆'会不时更新本隐私权政策。 您在同意'留忆'服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于'留忆'服务使用协议不可分割的一部分。\n\n1.适用范围\n\na) 在您注册'留忆'帐号时，您根据'留忆'要求提供的个人注册信息；\nb) 在您使用'留忆'网络服务，或访问'留忆'平台网页时，'留忆'自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；\nc) '留忆'通过合法途径从商业伙伴处取得的用户个人数据。\n您了解并同意，以下信息不适用本隐私权政策：\na) 您在使用'留忆'平台提供的搜索服务时输入的关键字信息；\nb) '留忆'收集到的您在'留忆'发布的有关信息数据，包括但不限于参与活动、成交信息及评价详情；\nc) 违反法律规定或违反'留忆'规则行为及'留忆'已对您采取的措施。\n\n2.信息使用\n\na) '留忆'不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和'留忆'（含'留忆'关联公司）单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。\nb) '留忆'亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何'留忆'平台用户如从事上述活动，一经发现，'留忆'有权立即终止与该用户的服务协议。\nc) 为服务用户的目的，'留忆'可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与'留忆'合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。\n\n3.信息披露\n\n在如下情况下，'留忆'将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：\na) 经您事先同意，向第三方披露；\nb) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\nc) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\nd) 如您出现违反中国有关法律、法规或者'留忆'服务协议或相关规则的情况，需要向第三方披露；\ne) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；\nf) 在'留忆'平台上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，'留忆'有权决定向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决。\ng) 其它'留忆'根据法律、法规或者网站政策认为合适的披露。\n\n4.信息存储和交换\n\n'留忆'收集的有关您的信息和资料将保存在'留忆'及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或'留忆'收集信息和资料所在地的境外并在境外被访问、存储和展示。\n\n5.Cookie的使用\n\na) 在您未拒绝接受cookies的情况下，'留忆'会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的'留忆'平台服务或功能。'留忆'使用cookies可为您提供更加周到的个性化服务，包括推广服务。\nb) 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的'留忆'网络服务或功能。\nc) 通过'留忆'所设cookies所取得的有关信息，将适用本政策。\n\n6.信息安全\n\na) '留忆'帐号均有安全保护功能，请妥善保管您的用户名及密码信息。'留忆'将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。\nb) 在使用'留忆'网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是'留忆'用户名及密码发生泄露，请您立即联络'留忆'客服，以便'留忆'采取相应措施。\n\n7.遵守法律\n\n您同意遵守中华人民共和国相关法律法规的所有规定，并对以任何方式使用您的密码和您的账号使用本服务的任何行为及其结果承担全部责任。如您的行为违反国家法律和法规的任何规定，可能构成犯罪的，将被追究刑事责任，并由您承担全部法律责任。如果'留忆'有理由认为您的任何行为，包括但不限于您的任何言论和其它行为违反或可能违反国家法律和法规的任何规定，'留忆'可在任何时候不经任何事先通知终止向您提供服务。"
        userTermsLabel.lineBreakMode = .byWordWrapping
        userTermsLabel.numberOfLines = 0
        userTermsLabel.font = UIFont.systemFont(ofSize: 14)
        userTermsLabel.textColor = UIColor.darkText
        let string = userTermsLabel.text
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundingRect = string?.boundingRect(with: CGSize(width: self.view.frame.width - 15, height: 0), options: option, attributes: [NSFontAttributeName:userTermsLabel.font],context: nil)
        userTermsLabel.frame = CGRect(x: 10, y: 50, width: (boundingRect?.size.width)!, height: (boundingRect?.size.height)!)
        scrollView.contentSize = CGSize(width: (boundingRect?.size.width)!, height: (boundingRect?.size.height)! + 60)
        scrollView.addSubview(userTermsLabel)
        
        createNavBar()
        
    }
    
    //创建导航栏
    func createNavBar() {
        navBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        navBar?.isTranslucent = false
        navBar?.barTintColor = #colorLiteral(red: 0.2283354998, green: 0.7348412871, blue: 0.498880744, alpha: 1)
        navBar?.tintColor = UIColor.white
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)]
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.pushItem(makeNavBar(), animated: true)
        self.view.addSubview(navBar!)
    }
    
    //设置导航栏左右按钮、标题
    func makeNavBar() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftBtn = UIBarButtonItem.init(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(backToRegister))
        navigationItem.title = "用户条款"
        //设置导航项左边的按钮
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        return navigationItem
    }
    
    //返回“注册”页面
    func backToRegister() {
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
