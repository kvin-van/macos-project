//
//  Person.swift
//  KVC
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class Person: NSObject {
    @objc var name: String?
    @objc var age:  Int = 0
    @objc var phone: Phone?
    
    convenience init(_ attributes:Dictionary<String,Any>) {
        self.init()
        self.setValuesForKeys(attributes)
    }
    
   
    override func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey inKey: String) throws {
        
        if inKey == "age" {
            let iAge = ioValue.pointee
            print("iAge \(String(describing: iAge))")
        }
        if inKey == "name" {
            let iName = ioValue.pointee
            print("iName \(String(describing: iName))")
        }
        _ = try? super.validateValue(ioValue, forKey: inKey)
    }
    
    override func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKeyPath inKeyPath: String) throws {


    }
    
}
