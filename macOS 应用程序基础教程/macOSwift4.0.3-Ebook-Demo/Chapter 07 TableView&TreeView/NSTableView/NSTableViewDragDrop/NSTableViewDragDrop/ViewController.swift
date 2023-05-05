//
//  ViewController.swift
//  NSTableViewDragDrop
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    var datas = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 开启tableView的拖放功能
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: "public.data")])
        tableView.setDraggingSourceOperationMask(.every, forLocal: true)
        
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
    }
    
}

// 实现拖放代理方法
extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    // 返回tableView的行数
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
    
    // 返回tableView的每一行的视图
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let data = self.datas[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
        //单元格数据
        let value = data[key]
        
        //根据表格列的标识,创建单元视图
        let cell = tableView.makeView(withIdentifier: key, owner: self)
        let subviews = cell?.subviews
        if (subviews?.count)!<=0 {
            return nil
        }
        
        let textField = subviews?[0] as! NSTextField
        if value != nil {
            textField.stringValue = value as! String
        }
        
        return cell
    }
    
    // 开始拖放
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        pboard.declareTypes([NSPasteboard.PasteboardType(rawValue: "public.data")], owner: self)
        pboard.setData(data, forType: NSPasteboard.PasteboardType(rawValue: "public.data"))
        return true
    }
    
    // 接收拖放
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        return .move
    }
    
    // 处理拖放
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let rowData = info.draggingPasteboard.data(forType: NSPasteboard.PasteboardType(rawValue: "public.data")),
              let rowIndexes = NSKeyedUnarchiver.unarchiveObject(with: rowData) as? IndexSet else {
            return false
        }
        var targetIndex = row > rowIndexes.first! ? row - rowIndexes.count : row
        
        for index in rowIndexes {
            if index < targetIndex {
                self.datas.insert(self.datas.remove(at: index), at: targetIndex - 1)
                targetIndex = targetIndex - 1
            } else {
                self.datas.insert(self.datas.remove(at: index), at: targetIndex)
            }
        }
        
        tableView.reloadData()
        return true
    }
}


