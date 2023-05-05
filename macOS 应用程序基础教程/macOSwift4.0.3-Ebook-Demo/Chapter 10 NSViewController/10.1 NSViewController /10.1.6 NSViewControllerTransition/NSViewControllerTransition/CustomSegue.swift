//
//  CustomSegue.swift
//  NSViewControllerTransition
//
//  Created by iDevFans on 16/7/17.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

//当在xib的 action里面 推送界面选择Custom 的时候 需要重写此功能 并且在链接处 添加此类
class CustomSegue: NSStoryboardSegue {

    override func perform(){
        
        let sourceViewController      = self.sourceController as! NSViewController;
        let destinationViewController = self.destinationController as! NSViewController //destinationController 目的地控制器
        
        let animator = PresentCustomAnimator()
        
        sourceViewController.present(destinationViewController , animator: animator)
        
    }
}
