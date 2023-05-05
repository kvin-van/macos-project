//
//  ViewController.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/21.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var gEventHandler: Any?
    var lEventHandler: Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startGlobalEventMoniter()
        self.startLocalEventMoniter()
        
        self.view.window?.makeFirstResponder(self)
    }

    override func mouseDown(with event: NSEvent) {
        
        print("鼠标mouseDown event \(event)")
    }
    
    override func keyDown(with event: NSEvent) {
        print("按键keyDown event \(event)")
    }

    func startGlobalEventMoniter() {
        self.gEventHandler = NSEvent.addGlobalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown,NSEvent.EventTypeMask.leftMouseDown], handler: {  event in
           
            print("全局事件global event \(event)")
        })
    }
    
    
    
    
    func startLocalEventMoniter() {
        self.lEventHandler = NSEvent.addLocalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown,NSEvent.EventTypeMask.leftMouseDown], handler: {event in
            print("局部时间local event \(event)")
            return event
          }
        )
    }
    
    
    func stopEventMoniter() {
        NSEvent.removeMonitor(self.gEventHandler!)
        NSEvent.removeMonitor(self.lEventHandler!)
    }

    
    
}


extension ViewController: NSTextFieldDelegate,NSTextViewDelegate {
    
     //MARK: NSTextFieldDelegate
    
     func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            NSLog("textField 按下回车键!")
            return true
        }
        if commandSelector == #selector(NSResponder.deleteBackward(_:)) {
            NSLog("textField delete key pressed!按下删除键")
            return true
        }
        
        return false
    }
    
    
    //MARK: NSTextViewDelegate
    
    func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            NSLog("textView Enter key pressed!按下回车键")
            return true
        }
        if commandSelector == #selector(NSResponder.deleteBackward(_:)) {
            NSLog("textView delete key pressed!按下删除键")
            return true
        }
        
        if commandSelector == #selector(NSResponder.insertTab(_:)) {
            NSLog("textView tab key pressed!")
            return true
        }
        
        return false
    }
}





