//
//  ZYDatePickerView.swift
//  ZYDatePickerView
//
//  Created by Pack Zhang on 16/5/11.
//  Copyright © 2016年 Pack Zhang. All rights reserved.
//

import UIKit



class ZYDatePickerView: UIView {
    
    var block: ((timeStr: String)->())?

    class func showDatePickerView(datePickerMode: UIDatePickerMode, themeColor: UIColor?, doneButtonClickBlock:((timeStr: String)->())) {
        
        let datePickerView = ZYDatePickerView.datePickerView()
        
        datePickerView.datePicker.datePickerMode = datePickerMode
        
        datePickerView.titleView.backgroundColor = themeColor
        
        datePickerView.seperateView.backgroundColor = themeColor
        
        datePickerView.doneButton.setTitleColor(themeColor, forState: UIControlState.Normal)
        
        datePickerView.setUpUI()
        
        datePickerView.block = doneButtonClickBlock
        
    }
    
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        
        dateLabel.text = currentDateString()
    }
    
    @IBAction func doneButtonClick(sender: UIButton) {

        addAnimation()

        removeFromSuperview()

        coverView.removeFromSuperview()
        
        block!(timeStr: dateLabel.text!)
    }
    
    private class func datePickerView() -> ZYDatePickerView{
    
        let view = NSBundle.mainBundle().loadNibNamed("ZYDatePickerView", owner: self, options: nil).last as! ZYDatePickerView
        
        view.dateLabel.text = view.currentDateString()

        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }
    
    private func setUpUI() {
        
        UIApplication.sharedApplication().keyWindow?.addSubview(coverView)
        
        let size = UIScreen.mainScreen().bounds.size
        
        let W = size.width * 0.9
        
        let H = size.height * 0.45
        
        center = coverView.center
        
        bounds = CGRect(x: 0, y: 0, width: W, height: H)
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        addAnimation()
    }
    
    /*true为显示状态*/
    private var isShow: Bool = false
    
    private func addAnimation() {
        
        if !isShow {
            transform = CGAffineTransformMakeScale(0, 0)
        }

        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 20, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            
            if !self.isShow {
                self.transform = CGAffineTransformMakeScale(1, 1)
            }else{
                self.transform = CGAffineTransformScale(self.transform, 0, 0)
            }

            }) { (_) in
                
            self.isShow = !self.isShow
        }
        
    }
    
    
    private func currentDateString() -> String {
        let weekStr = weekdayStringFromDate(datePicker.date)
        
        let formatrer = NSDateFormatter()
        
        formatrer.dateFormat = "MM月dd日-@HH时mm分"
        
        formatrer.locale = NSLocale(localeIdentifier: "zh_CH")
        
        let dateStr = formatrer.stringFromDate(datePicker.date) as NSString
        
        let range = NSRange(location: 6, length: 1)
        
        return dateStr.stringByReplacingCharactersInRange(range, withString: weekStr)
    }

    private func weekdayStringFromDate(inputDate: NSDate) -> String{
        
        let weekDayArr = ["周日","周一","周二","周三","周四","周五","周六"]
        
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let timeZone = NSTimeZone.systemTimeZone()
        
        calender.timeZone = timeZone
        
        let theComponents = calender.component(NSCalendarUnit.Weekday, fromDate: inputDate)
        
        return weekDayArr[theComponents-1]
    }
    
    // MARK: - 懒加载
    private lazy var coverView : UIView = {
        let frame = UIScreen.mainScreen().bounds
        let coverV = UIView(frame: frame)
        coverV.backgroundColor = UIColor.blackColor()
        coverV.alpha = 0.2
        return coverV
    }()
    
    @IBOutlet weak var seperateView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    
}
