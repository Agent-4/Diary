//
//  UserThemeColor.swift
//  Diary
//
//  Created by moxiaohao on 2017/4/6.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class UserThemeColor: NSObject {
    static func setColor() {
        let theme = UserDefaults.standard
        if theme.object(forKey: "colorIndex") != nil {
            switch theme.object(forKey: "colorIndex") as! Int {
            case 0: self.py_setThemeColor(#colorLiteral(red: 0.2274509804, green: 0.7333333333, blue: 0.4980392157, alpha: 1))
            case 1: self.py_setThemeColor(#colorLiteral(red: 1, green: 0.3725490196, blue: 0.3647058824, alpha: 1))
            case 2: self.py_setThemeColor(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))
            case 3: self.py_setThemeColor(#colorLiteral(red: 0, green: 0.6, blue: 1, alpha: 1))
            case 4: self.py_setThemeColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
            case 5: self.py_setThemeColor(#colorLiteral(red: 1, green: 0.4863265157, blue: 0, alpha: 1))
            default: self.py_setThemeColor(#colorLiteral(red: 0.2274509804, green: 0.7333333333, blue: 0.4980392157, alpha: 1))
            }
        }else { self.py_setThemeColor(#colorLiteral(red: 0.2274509804, green: 0.7333333333, blue: 0.4980392157, alpha: 1)) }
    }
}
