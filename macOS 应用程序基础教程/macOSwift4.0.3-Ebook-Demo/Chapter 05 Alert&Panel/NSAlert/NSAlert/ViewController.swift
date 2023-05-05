//
//  ViewController.swift
//  NSAlert
//
//  Created by iDevFans on 16/7/7.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var userNameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!

    @IBOutlet weak var confirmField: NSSecureTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
//    NSAlert *alert = [[NSAlert alloc] init];
//    //增加一个按钮
//    [alert addButtonWithTitle:@"Ok"];
//    //提示的标题
//    [alert setMessageText:@"Alert"];
//    //提示的详细内容
//    [alert setInformativeText:@"password length must be more than 6 "];
//    //设置告警风格
//    [alert setAlertStyle:NSInformationalAlertStyle];
//    //开始显示告警
//    [alert beginSheetModalForWindow:self.window
//    completionHandler:^(NSModalResponse returnCode){
//    //用户点击告警上面的按钮后的回调
//    }

    
    @IBAction func registerButtonClicked(_ sender: NSButton) {
        let password = self.passwordField.stringValue
        if password.count < 6 {
            let alert = NSAlert()
            //增加一个按钮
            alert.addButton(withTitle: "Ok")
            //提示的标题
            alert.messageText = "标题"
            //提示的详细内容
            alert.informativeText = "密码长度必须大于6 "
            //设置告警风格
            alert.alertStyle = .informational
            alert .beginSheetModal(for: self.view.window!, completionHandler: { returnCode in
                     //当有多个按钮是 可以通过returnCode区分判断
                     print("returnCode :\(returnCode)")
                }
            )
        }
    }
    
    @IBAction func cancelBtnAction(_ sender : NSButton)-> Void{
        let alert = NSAlert()
        alert.addButton(withTitle: "cancel")
        alert.addButton(withTitle: "ok")
        alert.messageText = "title"
        alert.informativeText = "信息性文本"

        let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = NSImage(named: NSImage.Name(rawValue: "circle"))
        imageView.layer?.backgroundColor = NSColor.green.cgColor
        imageView.wantsLayer = true
        imageView.layer?.borderColor = NSColor.black.cgColor
        imageView.layer?.borderWidth = 2
        alert.accessoryView = imageView
//        alert.alertStyle = .informational
        //== alert.runModal()
        alert.beginSheetModal(for: self.view.window!) { btnCode in
            print("\(btnCode)")
        }
    }
}





