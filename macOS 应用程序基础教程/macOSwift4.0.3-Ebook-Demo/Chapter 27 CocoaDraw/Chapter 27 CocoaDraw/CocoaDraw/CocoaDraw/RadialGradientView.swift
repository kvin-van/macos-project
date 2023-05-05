//
//  RadialGradientView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

//径向渐变视图
class RadialGradientView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
//        self.drawFromCenter() //从中心绘制
        
//        self.drawRelativeCenterPosition() //绘图相对中心位置
       
        self.drawInPath()//抽入路径
    }
    
    
    func drawFromCenter(){
        let bounds = self.bounds
//        let aGradient = NSGradient(starting: NSColor.blue, ending:  NSColor.green)
        let aGradient = NSGradient(colors: [NSColor.blue,NSColor.green,NSColor.red])
        let centerPoint = NSMakePoint(NSMidX(bounds), NSMidY(bounds))
        let otherPoint = NSMakePoint(centerPoint.x + 10.0, centerPoint.y + 10.0)
       
        aGradient?.draw(fromCenter: centerPoint, radius: 50, toCenter: otherPoint, radius: 5.0, options: .drawsBeforeStartingLocation)
        //aGradient?.draw(fromCenter: centerPoint, radius: 40, toCenter: otherPoint, radius: 5.0, options: .drawsAfterEndingLocation)
    }
    
    func drawRelativeCenterPosition(){
         let aGradient = NSGradient(colorsAndLocations:
            (NSColor.red, 0.0),
            (NSColor.green,0.5),
            (NSColor.yellow,0.75),
            (NSColor.blue,1.0))
        let startPoint = NSMakePoint(1, -1)
        let bounds = self.bounds
        aGradient?.draw(in: bounds, relativeCenterPosition: startPoint)
    }
    
    
    func drawInPath(){
        let aGradient = NSGradient(colorsAndLocations:
            (NSColor.red, 0.0),
                                   (NSColor.green,0.5),
                                   (NSColor.yellow,0.75),
                                   (NSColor.blue,1.0))
        let startPoint = NSMakePoint(1, -1)
        let bounds = self.bounds
        
        let path = NSBezierPath()
        path.appendRect(bounds)
        
        aGradient?.draw(in: path, relativeCenterPosition: startPoint)
    }

}

