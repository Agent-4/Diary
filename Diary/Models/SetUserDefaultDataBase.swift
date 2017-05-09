//
//  SetUserDefaultDataBase.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/15.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import RealmSwift

func setDefaultRealmForUser(username: String) {
    var config = Realm.Configuration()
    // 使用默认的目录，但是使用用户名来替换默认的文件名
    config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")
    // 将这个配置应用到默认的 Realm 数据库当中
    Realm.Configuration.defaultConfiguration = config
}
