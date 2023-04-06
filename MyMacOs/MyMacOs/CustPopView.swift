//
//  CustPopView.swift
//  MyMacOs
//
//  Created by 王本东 on 2023/3/20.
//

import Foundation
import AppKit

class CustPopView : NSViewController
{
    //xib初始化
//    convenience init() {
//        var nibNameOrNil = String?("CustPopView")
//        //考虑到xib文件可能不存在或被删，故加入判断
//        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil {
//            nibNameOrNil = nil
//            print("CustPopView 空了")
//        }
//        self.init(nibName: nibNameOrNil, bundle: nil)
//    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
