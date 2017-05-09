//
//  MOComposeCell.swift
//  Diary
//
//  Created by moxiaohao on 2016/12/5.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

// 协议代理
protocol MOComposeCellDelegate: NSObjectProtocol {
    func addOrChangePicture(cell: MOComposeCell)
    func deletePicture(cell: MOComposeCell)
}

class MOComposeCell: UICollectionViewCell {
    
    weak var delegate: MOComposeCellDelegate?
    
    var image: UIImage? {
        didSet {
            if let iamge = image {
                addButton.setBackgroundImage(iamge, for: .normal)
                addButton.setBackgroundImage(iamge, for: .highlighted)
                deleteButton.isHidden = false
            } else {
                addButton.setBackgroundImage(UIImage(named: "compose_pic_add"), for: .normal)
                addButton.setBackgroundImage(UIImage(named: "compose_pic_add"), for: .highlighted)
                deleteButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addButton: UIButton = UIButton(title: nil, bgImage: "compose_pic_add", target: self, selector: #selector(addOrChangePicture))
    
    lazy var deleteButton: UIButton = UIButton(title: nil, bgImage: "compose_photo_close", target: self, selector: #selector(deletePicture))
    
}

extension MOComposeCell {
    func setupUI () {
        deleteButton.frame = CGRect.init(x: self.frame.width - 30, y: 0, width: 30, height: 30)
        deleteButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        addButton.frame = CGRect.init(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 20)
        contentView.addSubview(addButton)
        contentView.addSubview(deleteButton)
    }
}

extension MOComposeCell {
    @objc fileprivate func addOrChangePicture() {
        delegate?.addOrChangePicture(cell: self)
    }
    
    @objc fileprivate func deletePicture() {
        delegate?.deletePicture(cell: self)
    }
}
