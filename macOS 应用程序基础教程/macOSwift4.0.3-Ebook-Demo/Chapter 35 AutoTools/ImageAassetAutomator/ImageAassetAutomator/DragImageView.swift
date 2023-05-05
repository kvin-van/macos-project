//
//  DragImageView.swift
//  ImageAassetAutomator
//
//  Created by iDevFans on 16/8/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


public protocol DragImageZoneDelegate: class {
    func didFinishDragWithFile(_ filePath:String)
}

class DragImageView: NSImageView {
    weak var delegate: DragImageZoneDelegate?
    //1.创建一个字典来定义期望的URL类型（图片）  仅为了performDragOperation 函数
    let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:NSImage.imageTypes]
    
    func dropAreaFadeIn() {
        self.alphaValue = 1.0
    }
    
    func dropAreaFadeOut() {
        self.alphaValue = 0.2
    }
}

extension DragImageView  {
    // 实现 NSDraggingDestination 代理协议接口
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let sourceDragMask = sender.draggingSourceOperationMask
        let pboard = sender.draggingPasteboard
        let fileURLType = NSPasteboard.PasteboardType.backwardsCompatibleFileURL
        if (pboard.types?.contains(fileURLType))! {
            if sourceDragMask == .copy {
                return .copy
            }
            if sourceDragMask == .link {
                return .link
            }
        }
        return .every
    }
    //拖动已退出
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.dropAreaFadeOut()
    }
    
    //原始代码
    //拖放完成后 执行 DragImageZoneDelegate 代理协议回调
//    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
//        let pboard = sender.draggingPasteboard
//        self.dropAreaFadeOut()
//        let fileURLType = NSPasteboard.PasteboardType.backwardsCompatibleFileURL
//        if (pboard.types?.contains(fileURLType))! {
//            var filePath: String?
//            if #available(OSX 10.13, *) {// 如果是 10.13 及以上系统，可以直接获取 URL 类型的文件路径
//                if let utTypeFilePath = pboard.propertyList(forType:fileURLType) as? URL {
//                    filePath = utTypeFilePath.path
//                }
//            }
//            else {// 如果是 10.13 以下系统，需要将 UTType 类型的文件路径转换成标准路径
//                // UTType 类型的文件路径，需要转换成标准路径
//                if let utTypeFilePath = pboard.string(forType:fileURLType) {
//                    filePath =  URL(fileURLWithPath: utTypeFilePath).standardized.path
//                }
//            }
//
//            // 如果代理存在，且文件路径存在，则调用代理方法
//            if let dragDelegate = delegate , let filePath = filePath {
//                dragDelegate.didFinishDragWithFile(filePath)
//            }
//        }
//        return true
//    }
    
    //新调试代码
    //拖放完成后 执行 DragImageZoneDelegate 代理协议回调
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pboard = sender.draggingPasteboard
        self.dropAreaFadeOut()
        let point = convert(sender.draggingLocation, from: nil) //中心点
            print("\(point)")
        // 判断是否拖进单文件
        if pboard.pasteboardItems!.count <= 1 {
            if let urls = pboard.readObjects(forClasses: [NSURL.self], options: filteringOptions) as? [URL], urls.count > 0 {
                print("\(urls)")
                let urlPath : NSURL = urls[0] as NSURL
            //在DestinationView中自定的协议DestinationViewDelegate传送数据
                if let dragDelegate = delegate , let filePath = urlPath.path {
                    dragDelegate.didFinishDragWithFile(filePath)
                }
            }
           }
           else { //多文件，目前暂不支持
//               filelist = [pboard propertyListForType:NSPasteboardTypeFileURL];
           }
        
        return true
    }
    
}
