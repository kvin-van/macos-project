//
//  DrawView.swift
//  MyMacOs
//
//  Created by 王本东 on 2023/3/3.
//

import Foundation
import Cocoa
import SwiftUI
class DrawView : NSView
{
    // MARK: - 属性
    override var  isFlipped : Bool {  //翻转
        return true
    }
    
    // MARK: - 方法
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.configLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        //画字
        let text : NSString = "哈哈哈"
        let font  = NSFont(name: "Palatino-Roman", size: 14)
        let attrs = [NSAttributedString.Key.font : font ,NSAttributedString.Key.foregroundColor : NSColor.blue , NSAttributedString.Key.backgroundColor : NSColor.gray]  //字体颜色 foregroundColor
        let  location = NSPoint(x: 20, y: 50)
        text.draw(at: location , withAttributes: attrs as [NSAttributedString.Key : Any])
    }
    
    //自定义层
    func configLayer(){
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.green.cgColor
        self.layer?.cornerRadius = 10
        self.layer?.borderWidth = 2
        self.layer?.borderColor = NSColor.black.cgColor
        
    }
    
    override func mouseDown(with event: NSEvent) {
        self.saveOfImage()  //  失败
//        self.saveURL() // 成功
    }
    
    //原来报错 Sandbox extension creation failed: client lacks entitlements? for path（沙盒扩展创建失败：客户端缺少权限？用于路径）
    //因为把 Enable app Sanbox 设置成了 yes
    func saveOfImage(){
//        self.lockFocus()
        let image = NSImage(data:self.dataWithPDF(inside: self.bounds))
//        self.unlockFocus()
        let imageData = image!.tiffRepresentation//转换成 data
        let fileManager = FileManager.default
        //写死的文件路径
        let path = "/Users/wangbendong/Desktop/ceshi.png"
        if(fileManager.createFile(atPath: path, contents: imageData, attributes: nil)){
        print("保存成功")
    }else{
        print("保存失败")
    }
    
        //定位文件路径
        let fileURL = URL(fileURLWithPath: path)
        NSWorkspace.shared.activateFileViewerSelecting([fileURL])//里面是 数组很容易忽略
    }
    
    //保存
    func saveURL() -> Void {
        let savePanel = NSSavePanel()
//        savePanel.url = URL(fileURLWithPath: "/Users/wangbendong/Desktop/ceshi.png")
        savePanel.allowedContentTypes = [.png]
//        savePanel.allowedFileTypes = ["png","jpg"]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.isExtensionHidden = false
        savePanel.allowsOtherFileTypes = true
        savePanel.title = "保存你的图片"
        savePanel.message = "选择存储图像的文件夹和名称"
        savePanel.nameFieldLabel = "文件名："
        savePanel.tagNames = ["红色"]
        
        let response = savePanel.runModal()
        let headImage = NSImage(named: "50icon")!
        let imageData = headImage.tiffRepresentation //转换成 data
        try? imageData!.write(to: (savePanel.url ?? URL(string: "/Users/wangbendong/Desktop/ceshi.png"))!)
//        return response == .OK ? savePanel.url : nil
    }
    
}


