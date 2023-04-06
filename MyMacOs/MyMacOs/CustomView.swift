//
//  CustomView.swift
//  MyMacOs
//
//  Created by 王本东 on 2023/3/13.
//

import Foundation
import AppKit

final class CustomView: NSView {
    
    // MARK: - 属性
    override var isFlipped: Bool{
        get{
            return true
        }
    }
    
    // MARK: - 方法
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.recieveFrameChangeNotification), name: NSView.frameDidChangeNotification, object: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func recieveFrameChangeNotification(_notification : Notification){
        let newframe = self.frame
        print("坐标变化\(newframe)")
    }
    
    
}
