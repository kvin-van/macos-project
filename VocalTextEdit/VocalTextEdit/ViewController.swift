//
//  ViewController.swift
//  VocalTextEdit
//
//  Created by 王本东 on 27/02/2023.
//

import Cocoa

class ViewController: NSViewController {
//属性
    @IBOutlet weak var textView : NSTextView!
    @IBOutlet weak var saveBtn : NSButton!
    
    var textContents : String
    {
        get{
            return textView.string
        }
        set (newdata){
            textView.string = newdata
        }
    }
    
    //系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
//方法
    let speech = NSSpeechSynthesizer()
    @IBAction func speakbuttonClicked(_sender : NSButton){
        print("文本内容是：\(textView.string)")
        if  textView.string.count>0 {
            speech.startSpeaking(textView.string)
        }else{
            speech.startSpeaking("没有内容 空")
        }
    }
    
    @IBAction func stopButtonClicked(_sender : NSButton){
        print("停止点击按钮")
        speech.stopSpeaking(at: NSSpeechSynthesizer.Boundary.immediateBoundary);//immediateBoundary立即边界wordBoundary单词边界 sentenceBoundary句子边界
    }
    
    @IBAction  func saveTextFile (_sender : NSButton){
        do {
            let text = textView.string
            let filePath : URL = URL(fileURLWithPath: "/Users/wangbendong/Desktop/macos.txt")
            let filemanager = FileManager.default
            if !filemanager.fileExists(atPath: "/Users/wangbendong/Desktop/macos.txt"){
                let result = filemanager.createFile(atPath: "/Users/wangbendong/Desktop/macos.txt", contents: text.data(using: String.Encoding.utf8))
//                try text.data(using: String.Encoding.utf8)?.write(to: filePath)
                print(result)
            }else{
                  try text.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
            }
        } catch {
            print("失败 ")
        }
    }
    

    //表示的对象
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

