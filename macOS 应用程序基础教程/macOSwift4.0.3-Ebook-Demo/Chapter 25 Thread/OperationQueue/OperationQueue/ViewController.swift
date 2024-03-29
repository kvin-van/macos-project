//
//  ViewController.swift
//  OperationQueue
//
//  Created by iDevFans on 16/9/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var leftImageView: NSImageView!
    
    @IBOutlet weak var rightImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBlockOp()
        
       // self.downImage()
        //任务优先级
        //self.opLevel()
        
        //开启依赖
//        self.opDependency()
      
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    func addBlockOp(){
        let opt = BlockOperation() //模块操作
        opt.addExecutionBlock({
            print("Run in block 1 ")
        })
        opt.addExecutionBlock({
            print("Run in block 2 ")
        })
        opt.addExecutionBlock({
            print("Run in block 3 ")
        })
        opt.addExecutionBlock({
            print("Run in block 4 ")
        })
        OperationQueue.current!.addOperation(opt)
        
        //completionBlock 用于设置 Operation 完成时的回调。
        opt.completionBlock = {
            print("Run All block Opreation ")
        }
        
//        opt.cancel()
//        OperationQueue.current?.isSuspended = false
//        OperationQueue.current?.isSuspended = true
    
    }

    
    func downImage(){
        
        let url1 = URL(string: "http://www.jobbole.com/wp-content/uploads/2016/01/75c6c64ae288896908d2c0dcd16f8d65.jpg")
        
        let op1 = HTTPImageOperation(imageURL: url1)
        
        op1.downCompletionBlock = {( _ image: NSImage?) -> () in
            if let img = image {
                self.leftImageView.image = img

            }
        }
        OperationQueue.main.addOperation(op1)
    }
    //任务优先级
    func opLevel(){
        let aQueue = OperationQueue()
        let opt1 = BlockOperation()
        opt1.queuePriority = .veryLow //优先级
        opt1.addExecutionBlock({() -> Void in
            print("Run in block 1 ")
        })
        let opt2 = BlockOperation()
        opt2.queuePriority = .veryLow
        opt2.addExecutionBlock({() -> Void in
            print("Run in block 2 ")
        })
        let opt3 = BlockOperation()
        opt3.queuePriority = .veryHigh
        opt3.addExecutionBlock({() -> Void in
            print("Run in block 3 ")
        })
        aQueue.addOperations([opt1, opt2, opt3], waitUntilFinished: false)
    }
    
    //开启依赖
    func opDependency(){
        let aQueue = OperationQueue()
        let opt1 = BlockOperation()
        opt1.addExecutionBlock({() -> Void in
            print("Run in block 1 ")
        })
        let opt2 = BlockOperation()
        opt2.addExecutionBlock({() -> Void in
            print("Run in block 2 ")
        })
        opt2.addDependency(opt1) //添加依赖
        aQueue.addOperation(opt1)
        aQueue.addOperation(opt2)
    }
}





