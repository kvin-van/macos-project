//
//  Student.swift
//  KVO
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class Student: NSObject {
    @objc var name: String?
    @objc var address: String?  {
        
        willSet
            {
               self.willChangeValue(forKey: "address")
        }
        
        didSet
            {
                self.didChangeValue(forKey: "address")
             
        }
    }
    
    //自动 通知 观察者
    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        var automatic:Bool
        if key == "address" {
            automatic = false
        }
        else {
            automatic = super.automaticallyNotifiesObservers(forKey: key)
        }
        return automatic
    }

}







