//
//  Window.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/21.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa
import Foundation
class Window: NSWindow {
    
    override func sendEvent(_ event: NSEvent) {
//        NSLog("发送事件sendEvent \(event)")
        //对event做统计处理，内部转发处理
        super.sendEvent(event)
    }
    
    override func postEvent(_ event: NSEvent, atStart flag: Bool) {
//         NSLog("传递事件sendEvent \(event)")
         super.postEvent(event,atStart:flag)
    }
}



