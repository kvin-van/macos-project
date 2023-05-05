//
//  NSTextFieldX.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class NSTextFieldX: NSTextField {

//    - (void)insertText:(id)insertString {
//    NSLog(@"insertString %@",insertString);
//    }
//    
//    
    override func doCommand(by selector: Selector) {
        super.doCommand(by: selector)
    }
    
    override func moveUp(_ sender: Any?) {
        NSLog("上移moveUp")
    }
    override func moveDown(_ sender: Any?) {
        NSLog("下移moveDown")
    }
    override func moveLeft(_ sender: Any?) {
        NSLog("左移moveLeft")
    }
    override func moveRight(_ sender: Any?) {
        NSLog("右移moveRight")
    }
    
    override func insertNewline(_ sender: Any?) {
        NSLog("插入换行符insertNewline")
    }
    override func deleteBackward(_ sender: Any?) {
        NSLog("deleteBackward")
    }
    
    
    

    
    override func keyDown(with event: NSEvent) {
        
        NSLog("keyDown \(String(describing: event.characters)) modifierFlags = \(event.modifierFlags)")
        
        super.keyDown(with: event)
    }
    
    override func insertText(_ insertString: Any) {
        NSLog("insertString \(insertString)");
    }
    
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
//    override var canBecomeKeyView: Bool {
//        return false
//    }
//    
//    override var acceptsFirstResponder: Bool {
//        return true
//    }
//    
//    
//    override func becomeFirstResponder() -> Bool {
//        
//        return true
//    }
//    
//    override func resignFirstResponder() -> Bool {
//        return true
//    }

}
