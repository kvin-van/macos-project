//
//  Employee.swift
//  KVBEmploee
//
//  Created by iDevFans on 16/7/28.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa
//Emploee 雇员
class Employee: NSObject {
    @objc dynamic var id: NSInteger = 0
    @objc dynamic var name: String?
    @objc var age: NSInteger = 0  //继承NSObject  需要加@objc
    @objc dynamic var address: String?  //如果不加 dynamic 就不会生效
}

