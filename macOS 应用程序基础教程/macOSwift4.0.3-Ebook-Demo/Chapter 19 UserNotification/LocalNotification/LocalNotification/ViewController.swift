//
//  ViewController.swift
//  LocalNotification
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import UserNotifications

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.startLocalNotification()
        self.addLocalNotification() //自己成功
        
    }

    //本地通知
    func addLocalNotification(){
        // 创建一个UNUserNotificationCenter实例
        let center = UNUserNotificationCenter.current()
        // 请求用户授权推送通知
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                // 如果请求授权出错，打印错误信息
                print("请求授权出错: \(error.localizedDescription)")
            } else if granted {
                // 如果用户授权，打印授权信息
                print("用户已授权推送通知")
            } else {
                // 如果用户拒绝授权，打印拒绝信息
                print("用户拒绝授权推送通知")
            }
        }

        // 创建一个本地通知内容实例
        let content = UNMutableNotificationContent()
        // 设置通知标题
        content.title = "这是一个本地通知"
        // 设置通知正文
        content.body = "这是本地通知的正文内容"
        
        // 设置通知声音
        content.sound = UNNotificationSound.default
        // 设置通知图片
        if let imageURL = Bundle.main.url(forResource: "Menu", withExtension: "png") {
            let attachment = try! UNNotificationAttachment(identifier: "NotificationImage", url: imageURL, options: nil)
            content.attachments = [attachment]
        }
        // 创建一个本地通知触发器实例
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // 创建一个本地通知请求实例
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        // 将本地通知请求添加到通知中心
        center.add(request) { error in
            if let error = error {
                // 如果添加本地通知请求出错，打印错误信息
                print("添加本地通知请求出错: \(error.localizedDescription)")
            } else {
                // 如果添加本地通知请求成功，打印成功信息
                print("添加本地通知请求成功")
            }
        }
    }
    
    func startLocalNotification() {
        let notification = NSUserNotification()
        //消息标题
        notification.title = "Message"
        
        notification.hasReplyButton = true
        notification.hasActionButton = true
        notification.otherButtonTitle = "Reply"
        notification.contentImage = NSImage(named: "Menu")
        
        //消息详细信息
        notification.informativeText = "I have a dream!"
        //消息附加数据
        notification.userInfo = ["messageID":1000]
        //注册的时间
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 10) as Date
        //重复的间隔,5分钟一次
        notification.deliveryRepeatInterval?.minute = 1
        //设置代理
        NSUserNotificationCenter.default.delegate = self
        //注册本地推送
        NSUserNotificationCenter.default.scheduleNotification(notification)

    }
}



extension ViewController: NSUserNotificationCenterDelegate {
    //收到通知
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        print("didDeliver notification \(notification)")
    }
    //点击了通知
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        self.view.window?.orderFront(self)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}



