//
//  MoPicker.swift
//  Diary
//
//  Created by moxiaohao on 2017/03/20.
//  Copyright © 2016年 moxiaohao. All rights reserved.
//

import UIKit

public enum MoPickerStyle : Int32 {
    
    case nomal
    case date
}

protocol PickerDelegate : NSObjectProtocol {
    func chooseElements(picker: MoPicker, content: [Int:Int])
    func chooseDate(picker: MoPicker, date: Date)
}

class MoPicker: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var pickerDelegate : PickerDelegate?
    
    private let picker_height:CGFloat! = 260
    private var picker: UIPickerView = UIPickerView()
    private var datePicker: UIDatePicker = UIDatePicker()
    private var content: [MoPickerObject]?
    private var pickerStyle: MoPickerStyle?
    private var backgroundBtn: UIButton = UIButton()
    private var tempDic: Dictionary = [Int:Int]()
    private var numComponents:Int = 0
    
    private var maxDate: Date = Date()  // 初始最大日期 = now
    private var minDate: Date = Date.init(timeIntervalSinceNow: -1577923200) // 初始最小日期 = now - 50年
    
    var contentArray:[MoPickerObject]? {
        get {
            return self.content
        }
        set {
            self.content = newValue
            self.initializeContentArray()
        }
    }
    
    var max_Date:Date? {
        set(newValue){
            self.maxDate = newValue!
            self.setMaxDate()
        }
        get {
            return maxDate
        }
    }
    
    var min_Date:Date? {
        set(newValue){
            self.minDate = newValue!
            self.setMinDate()
        }
        get {
            return minDate
        }
    }

    init(delegate: PickerDelegate, style: MoPickerStyle) {
        pickerDelegate = delegate
        pickerStyle = style
        let v_frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: picker_height)
        super.init(frame: v_frame)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 249/255.0, alpha: 1.0)
        self.addSubview(view)
        
        let cancelBtn = UIButton(type: UIButtonType.system)
        cancelBtn.frame = CGRect(x: 0, y:  0, width: 60, height: 44)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.setTitle("取 消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.darkGray, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        let doneBtn = UIButton(type: UIButtonType.system)
        doneBtn.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 0, width: 60, height: 44)
        doneBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        doneBtn.setTitle("确 定", for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.darkGray, for: .normal)
        doneBtn.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        self.addSubview(doneBtn)
        
        backgroundBtn = UIButton(type: UIButtonType.system)
        backgroundBtn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        backgroundBtn.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        switch style {
        case .nomal:
            self.picker = UIPickerView(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: picker_height - 44))
            self.picker.delegate = self
            self.picker.dataSource = self
            self.picker.backgroundColor = UIColor.white
            self.addSubview(self.picker)
        case .date:
            self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: picker_height - 44))
            self.datePicker.datePickerMode = UIDatePickerMode.date
            self.datePicker.locale = Locale(identifier: "zh_CN")
            self.datePicker.backgroundColor = UIColor.white
            self.datePicker.maximumDate = max_Date // 最大时间
            self.datePicker.minimumDate = min_Date // 最小时间
            self.datePicker.addTarget(self, action: #selector(self.dateChoosePressed(datePicker:)), for: .valueChanged)
            self.addSubview(self.datePicker)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var row:Int = 0
        if let array = content {
            var tempArray:Array = array
            for i in 0...numComponents {
                let value:Int = tempDic[i] ?? 0
                if component == i {
                    row = tempArray.count
                }
                if tempArray.count > value {
                    let object = tempArray[value]
                    if let arr = object.subArray {
                        tempArray = arr
                    }else {
                        tempArray = [MoPickerObject]()
                    }
                }
                if component == i {
                    return row
                }
            }
            return 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerStyle == .nomal {
            self.picker_partingLine(color: UIColor.lightGray)
        }
        var str:String = ""
        if let array = content {
            var tempArray:Array = array
            for i in 0...numComponents {
                let value:Int = tempDic[i] ?? 0
                if component == i {
                    let object = tempArray[row]
                    str = object.title ?? "未知"
                }
                if tempArray.count > value {
                    let object = tempArray[value]
                    if let arr = object.subArray {
                        tempArray = arr
                    }else {
                        tempArray = [MoPickerObject]()
                    }
                }
            }
            return str
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempDic.updateValue(row, forKey: component)
        if (component + 1) < numComponents {
            for i in (component+1)..<numComponents {
                tempDic.updateValue(0, forKey:i)
                pickerView.selectRow(0, inComponent: i, animated: false)
            }
        }
        
        pickerView.reloadAllComponents()
    }
    
    func picker_partingLine(color: UIColor?) {
        let sep_color = color ?? UIColor.lightGray
        if #available(iOS 10.0, *) {
            for view in picker.subviews {
                if view.frame.size.height < 1 {
                    view.backgroundColor = sep_color
                }
            }
        }
    }
    
    private func initializeContentArray() {
        var temp:Int = 0
        if let array = content {
            if array.count > 0 {
                temp = 1
                tempDic[temp - 1] = 0
                var object = array.first
                while object?.subArray != nil {
                    temp += 1
                    tempDic[temp - 1] = 0
                    let arr = object?.subArray
                    if let temp_arr = arr {
                        if temp_arr.count > 0 {
                            object = temp_arr.first
                        }else { break }
                    }else{ break }
                }
            }
        }
        numComponents = temp
        picker.reloadAllComponents()
    }
    
    private func setMaxDate() {
        self.datePicker.maximumDate = max_Date
    }
    
    private func setMinDate() {
        self.datePicker.minimumDate = min_Date
    }

    func dateChoosePressed(datePicker: UIDatePicker) {
        //print("select date \(datePicker.date.string_from(formatter: "yyyy-MM-dd"))")
    }
    
    func doneButtonClick() {
        if pickerStyle == .nomal {
            pickerDelegate?.chooseElements(picker: self, content: tempDic)
        }else {
            pickerDelegate?.chooseDate(picker: self, date: datePicker.date)
        }
        self.hiddenPicker()
    }
    
    func cancelButtonClick(btn:UIButton) {
        self.hiddenPicker()
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self.backgroundBtn)
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3)
            self.frame.origin.y = UIScreen.main.bounds.size.height - self.picker_height
        }) { (finished: Bool) in
        }
    }
    
    private func hiddenPicker() {
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
            self.frame.origin.y = UIScreen.main.bounds.size.height
        }) { (finished: Bool) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.backgroundBtn.removeFromSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class MoPickerObject: NSObject {
    var title:String?
    var subArray:[MoPickerObject]?
    var code:String?
}

