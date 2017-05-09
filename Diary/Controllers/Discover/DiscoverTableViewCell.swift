//
//  DiscoverTableViewCell.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/15.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet weak var user_avatar: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var diary_content: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var diaryDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        user_avatar.layer.cornerRadius = 15
        user_avatar.layer.masksToBounds = true
        likeBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9)
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
