//
//  ViewController.swift
//  XXXBonjourNetWorkManagerTest
//
//  Created by iDevFans on 16/10/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import XXXBonjourNetWork  //因为是 上一个是swift3的包 报错。 又重新打了一个

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        XXXBonjourNetWorkManager.shared.start()
        Helper.show()
    }
}

