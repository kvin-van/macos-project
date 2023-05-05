//
//  PathView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class PathView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor

//         self.setLineCapStyle() //设置线帽样式
        
//         self.setLineJoinStyle()
        
//        self.setLineDashStyle() //虚线样式
        
//        self.drawWithFlatness()// 平滑度  注意 是 全局的！！
        
      //  self.drawMiterLimit()
        
       // self.drawPoint()
        
       // self.drawLine()
        
//       self.drawRegion() //画区域  三角
        
//        self.drawOval()//画椭圆
        
       self.drawRect6()
        
      // self.drawArc2()
        
        self.drawBezierPath()  //贝塞尔曲线
//        self.drawRadiusRect()
    }
    
    func setLineWidth(){
        
        //全局的线宽
        NSBezierPath.defaultLineWidth = 2.0
        
        //特定的Path设置线宽
        let thePath = NSBezierPath()
        thePath.lineWidth = 3.0
    }
    
    func setLineCapStyle(){
        
        let aPath1 = NSBezierPath()
        aPath1.lineWidth = 10.0
        aPath1.move(to: NSMakePoint(12.0, 20.0))
        aPath1.line(to: NSMakePoint(92.0, 20.0))
        aPath1.lineCapStyle = .butt
        aPath1.stroke()
        
        let aPath2 = NSBezierPath()
        aPath2.lineWidth = 10.0
        aPath2.move(to: NSMakePoint(12.0, 60.0))
        aPath2.line(to: NSMakePoint(92.0, 60.0))
        aPath2.lineCapStyle = .round
        aPath2.stroke()
        
        let aPath3 = NSBezierPath()
        aPath3.lineWidth = 10.0
        aPath3.move(to: NSMakePoint(12.0, 100.0))
        aPath3.line(to: NSMakePoint(92.0, 100.0))
        aPath3.lineCapStyle = .square
        aPath3.stroke()
    }
    
    
    func setLineJoinStyle(){
        
        
        let aPath1 = NSBezierPath()
        aPath1.lineWidth = 10.0
        aPath1.move(to: NSMakePoint(12.0, 20.0))
        aPath1.line(to: NSMakePoint(42.0, 40.0))
        aPath1.line(to: NSMakePoint(72.0, 20.0))
        aPath1.lineJoinStyle = .miter
        aPath1.stroke()
        
        let aPath2 = NSBezierPath()
        aPath2.lineWidth = 10.0
        aPath2.move(to: NSMakePoint(12.0, 60.0))
        aPath2.line(to: NSMakePoint(42.0, 80.0))
        aPath2.line(to: NSMakePoint(72.0, 60.0))
        aPath2.lineJoinStyle = .round
        aPath2.stroke()
        
        let aPath3 = NSBezierPath()
        aPath3.lineWidth = 10.0
        aPath3.move(to: NSMakePoint(12.0, 100.0))
        aPath3.line(to: NSMakePoint(42.0, 120.0))
        aPath3.line(to: NSMakePoint(72.0, 100.0))
        aPath3.lineJoinStyle = .bevel
        aPath3.stroke()
        
    }
    
    
    func setLineDashStyle(){
        
        let aPath1 = NSBezierPath()
        aPath1.move(to: NSMakePoint(12.0, 60.0))
        aPath1.line(to: NSMakePoint(192.0, 60.0))
        
        var lineDash = [CGFloat](repeating: 0.0, count: 2)
        lineDash[0] = 2.0
        lineDash[1] = 2.0
        aPath1.setLineDash(lineDash, count: 2, phase: 0.0)
        aPath1.stroke()
        
        let aPath2 = NSBezierPath()
        aPath2.move(to: NSMakePoint(12.0, 20.0))
        aPath2.line(to: NSMakePoint(192.0, 20.0))
        
        var lineDash2 = [CGFloat](repeating: 0.0, count: 4)
        lineDash2[0] = 2.0
        lineDash2[1] = 2.0
        lineDash2[2] = 4.0
        lineDash2[3] = 4.0
        aPath2.setLineDash(lineDash2, count: 4, phase: 0.0)
        aPath2.stroke()

    }
    
    func drawWithFlatness(){
        NSBezierPath.defaultFlatness = 20.0 //defaultFlatness默认平面度
    }
    
    
    func drawMiterLimit(){
        let aPath = NSBezierPath()
        aPath.move(to: NSMakePoint(10.0, 10.0))
        aPath.line(to: NSMakePoint(18.0, 110.0))
        aPath.line(to: NSMakePoint(26.0, 10.0))
        aPath.lineWidth = 5.0
        aPath.miterLimit = 5.0
        aPath.stroke()
    }
    
    func drawPoint(){
        let aPoint = NSPoint(x: 10, y: 10)
        let aRect  = NSRect(x: aPoint.x, y: aPoint.y, width: 1, height: 1)
//        NSRectFill(aRect)
    }
    
    
    func drawLine(){
        let aPath = NSBezierPath()
        aPath.move(to: NSMakePoint(10.0, 10.0))
        aPath.line(to: NSMakePoint(100.0, 10.0))
        aPath.stroke()
    }
    
    func drawRegion(){
        
        let aPath = NSBezierPath()
        aPath.move(to: NSMakePoint(10.0, 10.0))
        aPath.line(to: NSMakePoint(180.0, 10.0))
        aPath.line(to: NSMakePoint(100.0, 60.0))
        aPath.close()
        aPath.stroke()

    }
    
    func drawRect1(){
        let aPoint = NSMakePoint(10.0, 10.0)
        let aRect = NSMakeRect(aPoint.x, aPoint.y, 40.0, 40.0)
        NSBezierPath.stroke(aRect)
    }
    
    func drawRect2(){
        let aPoint = NSMakePoint(10.0, 10.0)
        let aRect = NSMakeRect(aPoint.x, aPoint.y, 40.0, 40.0)
        NSBezierPath.fill(aRect)

    }
    
    func drawRect3(){
        let aPoint = NSMakePoint(10.0, 10.0)
        let aRect = NSMakeRect(aPoint.x, aPoint.y, 40.0, 40.0)
        let thePath = NSBezierPath(rect: aRect)
        thePath.stroke()
    }
    
    func drawRect4(){
        let aRect = NSMakeRect(10.0, 10.0, 40.0, 40.0)
        let thePath = NSBezierPath()
        thePath.appendRect(aRect)
        thePath.stroke()
    }
    
    func drawRect6(){
        let aRect = NSMakeRect(10.0, 10.0, 40.0, 40.0)
//        NSFrameRect(aRect)
        aRect.frame()
    }
    
    
    func drawRadiusRect(){
        let aRect = NSMakeRect(10.0, 10.0, 40.0, 40.0)
        let path = NSBezierPath(roundedRect: aRect, xRadius: 10, yRadius: 10)
        path.stroke()
    }
    
    //画椭圆
    func drawOval(){
        //椭圆
//        let ovalPath = NSBezierPath(ovalIn: NSRect(x: 10, y: 10, width: 100, height: 50))
//        ovalPath.stroke()
        
        NSBezierPath.defaultFlatness = 20.0 //默认平面度  0 平滑  20 坡度
        let aRect = NSMakeRect(10.0, 10.0, 70, 100)
        let path = NSBezierPath(ovalIn: aRect)
        path.stroke()
    }
    
    func drawArc(){
        let arcPath = NSBezierPath()
        arcPath.move(to: NSMakePoint(30, 10))
        arcPath.appendArc(from: NSMakePoint(10, 30), to: NSMakePoint(60, 60), radius: 20)
        arcPath.stroke()
    }
    
    func drawArc2(){
        let arcPath = NSBezierPath()
        arcPath.appendArc(withCenter: NSMakePoint(60, 60), radius: 40, startAngle: 45, endAngle: 90)
        arcPath.stroke()
    }
    
    func drawBezierPath(){
        let path = NSBezierPath()
        path.move(to: NSMakePoint(20.0, 20.0))
        path.curve(to: NSMakePoint(160.0, 60.0), controlPoint1: NSMakePoint(80.0, 50.0), controlPoint2: NSMakePoint(90.0, 5.0))
        path.stroke()
      
    
    }
}











