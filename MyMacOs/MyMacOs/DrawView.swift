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
    
    func saveOfImage(){
//        self.lockFocus()
        let pdfData : NSImage = NSImage(data: self.dataWithPDF(inside: self.bounds))!
//        self.unlockFocus()
        let imageData = pdfData.tiffRepresentation //转换成 data
        let fileManage = FileManager.default
        let path = "/Users/wangbendong/Desktop/ceshi.png"
//        let path = "/Users/wangbendong/Documents/ceshi.png"
        if (fileManage.createFile(atPath: path, contents: imageData ,attributes: nil)){
            print("保存成功")
        }else{
            print("保存失败")
        }
        
        //定位文件路径
        let  fileUrl = URL(fileURLWithPath: path)
        NSWorkspace.shared.activateFileViewerSelecting([fileUrl])//里面是 数组很容易忽略
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


