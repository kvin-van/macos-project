//
//  ViewController.swift
//  HTTPCookie
//
//  Created by iDevFans on 16/9/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tokenCookie = HTTPCookie(properties: ViewController.creatHTTPCookie("TOKEN", vlaue: "token2022")) {
                   HTTPCookieStorage.shared.setCookie(tokenCookie)
               }
      
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
      
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    static func creatHTTPCookie(_ key: String, vlaue: String) -> [HTTPCookiePropertyKey : Any] {
        // 定义一个可变字典存放cookie键值对
        var properties: [HTTPCookiePropertyKey : Any] = [:]
        properties[.name] = key
        properties[.path] = "/"
        properties[.value] = vlaue
        properties[.secure] = true
        #if DEBUG
        let domain = "cs.hxquan.cn"
        #else
        let domain = "m.hxquan.cn"
        #endif
        properties[.domain] = domain
        properties[.version] = 0
        return properties
    }

}

