//
//  Document.swift
//  VocalTextEdit
//
//  Created by 王本东 on 2023/2/28.
//

import Foundation
import Cocoa

class Document : NSDocument {
    
    var contents : String  = ""
    
    enum Error : Swift.Error , LocalizedError{
        case  UTF8Encoding
        case UTF8Decoding
        
        var failureReason: String? {
            switch self{
            case.UTF8Encoding  : return "文件不能 utf-8 编码"
            case.UTF8Decoding : return "文件不能 utf-8  解码"
            }
        }
    }
    
     class func autosavesInPlace () -> Bool
    {
        return true
    }
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "main", bundle: Bundle.main)
        let windowcontroller = storyboard.instantiateController(withIdentifier: "Document window controller") as! NSWindowController
        
        let viewcontroller = windowcontroller.contentViewController as! ViewController
        viewcontroller.textContents = contents
        
        self.addWindowController(windowcontroller)
    }
    
    override func data(ofType typeName: String) throws -> Data {
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr , userInfo: nil)
        let windowController = windowControllers[0]
        let viewcontroller = windowController.contentViewController as! ViewController
        let contents = viewcontroller.textContents
        guard let data = contents.data(using: .utf8)  else {
            throw Document.Error.UTF8Encoding
        }
        return data
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr , userInfo: nil)
        guard let content = String(data: data, encoding: .utf8) else{
            throw Document.Error.UTF8Decoding
        }
        
//        let windowController = windowControllers[0]
//        let viewcontroller = windowController.contentViewController as! ViewController
//        viewcontroller.textView.string = content
        self.contents = content
    }
    
}


