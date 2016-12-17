//
//  MessagesTableViewController.swift
//  Diary
//
//  Created by 莫晓豪 on 2016/12/2.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    
    var messagesList: Dictionary<Int, [String]>?
    
    var messagesImgData = [
        ["image1":"messageAT.png"],
        ["image1":"messageComment.png"],
        ["image1":"messageSystem.png"]
    ]
    var myNAV: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //self.tableView.backgroundColor = #colorLiteral(red: 0.9685775638, green: 0.97814399, blue: 0.9813601375, alpha: 1)
        self.tableView?.tableFooterView = UIView(frame:CGRect.zero)
        self.messagesList =  [
            0:[String]([
                "@我的",
                "评论",
                "系统消息"])
        ]
        
        myNAV = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        
    }
    override func viewWillLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    //点击cell行时，让cell背景颜色一闪而过
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            let viewController = SettingViewController()
            viewController.hidesBottomBarWhenPushed = true
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: UIBarButtonItemStyle.plain,target: nil, action: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "messagesCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        let data = self.messagesList?[indexPath.section]
        let messagesItem = messagesImgData[indexPath.row]
        let rightIcon1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightIcon1.image = UIImage(named: "arrow_Right")
        
        cell?.accessoryView = rightIcon1
        cell?.textLabel?.text = data![indexPath.row]
        cell?.imageView?.image = UIImage(named: messagesItem["image1"]!)
        //修改cell选中的背景色
        cell?.selectedBackgroundView = UIView.init()
        cell?.selectedBackgroundView?.backgroundColor = UIColor.init(red: 245/255, green: 248/255, blue: 249/255, alpha: 1.0)
        
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
