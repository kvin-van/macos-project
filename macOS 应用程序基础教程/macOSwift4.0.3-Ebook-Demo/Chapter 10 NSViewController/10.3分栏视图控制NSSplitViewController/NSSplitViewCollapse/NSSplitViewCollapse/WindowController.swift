//
//  WindowController.swift
//  NSSplitViewCollapse
//
//  Created by iDevFans on 16/7/20.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func openCloseAction(_ sender: AnyObject) {
        
        
    }
    
    //toolbar  没有action 会自己变灰
    @IBAction func itemAction(_ sender: AnyObject) {
        print("itemAction")
        
    }

}
