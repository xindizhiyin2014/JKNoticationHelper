//
//  JKFastNotificationProtocol.swift
//  JKNoticationHelper_Swift
//
//  Created by JackLee on 2021/9/8.
//

import Foundation
//提供简便使用，不会自动移除通知的监听
public protocol JKFastNotificationProtocol {
    
    /// 添加通知的监听
    /// - Parameters:
    ///   - name: 通知的名字
    ///   - block: 处理通知的回调
    func jk_observe(name:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 添加一组通知的监听
    /// - Parameters:
    ///   - names: 通知的名字组成的数组
    ///   - block: 处理通知的回调
    func jk_observe(names:Array<String>,block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 移除通知的监听
    /// - Parameter name: 通知的名字
    func jk_removeObserve(for name:String) ->Void
    
    /// 发送通知
    /// - Parameter notificationName: 通知名字
    func jk_postNotification(notificationName:String) ->Void

    /// 发送通知
    /// - Parameters:
    ///   - notificationName: 通知名字
    ///   - object: 发送的对象
    ///   - userInfo: 用户信息
    func jk_postNotification(notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) ->Void

}

public extension JKFastNotificationProtocol {
    func jk_observe(name:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        jk_observe(names: [name], block: block)
    }
    
    func jk_observe(names:Array<String>,block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        for name in names {
            NotificationCenter.default.addObserver(forName: Notification.Name.init(name), object: nil, queue: nil, using: block)
        }
    }
    
    func jk_removeObserve(for name:String) ->Void {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.init(name), object: nil)
    }
    
    func jk_postNotification(notificationName:String) ->Void {
        jk_postNotification(notificationName: notificationName, object: nil, userInfo: nil)
    }
    
    func jk_postNotification(notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) ->Void {
        NotificationCenter.default.post(name: Notification.Name.init(notificationName), object: object, userInfo: userInfo)
    }
}
