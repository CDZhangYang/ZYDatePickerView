//
//  ViewController.swift
//  ZYDatePickerView
//
//  Created by Pack Zhang on 16/5/11.
//  Copyright © 2016年 Pack Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        ZYDatePickerView.showDatePickerView(UIDatePickerMode.Date, themeColor: UIColor.blueColor(), dateFormat: ZYDateFormat.YMD) { (timeStr) in
            print(timeStr)
        }
        
        
        
    }


}

