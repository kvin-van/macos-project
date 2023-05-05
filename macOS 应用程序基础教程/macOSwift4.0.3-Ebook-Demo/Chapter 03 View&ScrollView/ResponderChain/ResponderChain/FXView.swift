//
//  FXView.swift
//  ResponderChain
//
//  Created by iDevFans on 16/6/27.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Foundation
import AppKit

class FXView: NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        self.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    override func scrollWheel(with event: NSEvent) {
        NSLog("scrollWheel \(self)")//鼠标滚轮事件 在区域内滑轮响应
    }
}
