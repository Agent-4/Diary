//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/15.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {

    @IBOutlet weak var diary_view: UIView!
    @IBOutlet weak var date_day: UILabel!
    @IBOutlet weak var date_year_month: UILabel!
    @IBOutlet weak var diary_content: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var moodIcon: UIImageView!
    @IBOutlet weak var diary_picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        diary_view.layer.cornerRadius = 4
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
