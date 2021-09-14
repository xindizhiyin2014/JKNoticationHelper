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
    func jk_observeNotificaion(name:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 添加一组通知的监听
    /// - Parameters:
    ///   - names: 通知的名字组成的数组
    ///   - block: 处理通知的回调
    func jk_observeNotificaions(names:Array<String>,block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 移除通知的监听
    /// - Parameter name: 通知的名字
    func jk_removeObserveNotification(for name:String) ->Void
    
    /// 发送通知
    /// - Parameter notificationName: 通知名字
    func jk_postNotification(notificationName:String) ->Void
    
    /// 发送通知
    /// - Parameters:
    ///   - notificationName: 通知名字
    ///   - object: 发送的对象
    ///   - userInfo: 用户信息
    func jk_postNotification(notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) ->Void
    
    
    var notificationProxyList: [JKFastNotificationProxy] {get set}
}

private struct JKFastNotificationProtocolAssociatedKey {
    static var identifier: String = "notificationProxyList_identifier"
}

public extension JKFastNotificationProtocol {
    
    var notificationProxyList: [JKFastNotificationProxy] {
        get{ objc_getAssociatedObject(self, &JKFastNotificationProtocolAssociatedKey.identifier) as? [JKFastNotificationProxy] ?? [] }
        set { objc_setAssociatedObject(self, &JKFastNotificationProtocolAssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
     func jk_observeNotificaion(name:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        jk_observeNotificaions(names: [name], block: block)
    }
    
     func jk_observeNotificaions(names:Array<String>,block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        var tmpSelf = self
        let proxyArr = names.map { JKFastNotificationProxy(name: $0, block: block)}
        tmpSelf.notificationProxyList += proxyArr
    }
    
     func jk_removeObserveNotification(for name:String) ->Void {
        var tmpSelf = self
        tmpSelf.notificationProxyList.removeAll { $0.notificationName == name}
    }
    
    func jk_postNotification(notificationName:String) ->Void {
        jk_postNotification(notificationName: notificationName, object: nil, userInfo: nil)
    }
    
    func jk_postNotification(notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) ->Void {
        NotificationCenter.default.post(name: Notification.Name.init(notificationName), object: object, userInfo: userInfo)
    }
}

