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
    
    /// 在一定范围内监听通知事件
    /// - Parameters:
    ///   - moduleName: 模块名
    ///   - notificationName: 通知名字
    ///   - block: 通知事件处理
    func jk_observeNotification(at moduleName:String, notificationName:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 在一定范围内监听通知事件
    /// - Parameters:
    ///   - moduleName: 模块名
    ///   - notificationNames: 通知名字数组
    ///   - block: 通知事件处理
    func jk_observeNotifications(at moduleName:String, notificationNames:Array<String>, block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 在一定范围内监听通知事件
    /// - Parameters:
    ///   - moduleInstance: 模块实例对象
    ///   - notificationName: 通知名字
    ///   - block: 通知事件处理
    func jk_observeNotification(at moduleInstance:Any, notificationName:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void
    
    /// 在一定范围内监听通知事件
    /// - Parameters:
    ///   - moduleInstance: 模块实例对象
    ///   - notificationNames: 通知名字数组
    ///   - block: 通知事件回调
    func jk_observeNotifications(at moduleInstance:Any, notificationNames:Array<String>, block:@escaping ((_ notification:Notification) -> Void)) ->Void
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
    
    /// 在一定范围内发送通知
    /// - Parameters:
    ///   - moduleName: 模块名
    ///   - notificationName: 通知名字
    func jk_postNotification(at moduleName:String, notificationName:String) -> Void
    
    /// 在一定范围内发送通知
    /// - Parameters:
    ///   - moduleName: 模块名
    ///   - notificationName: 通知名字
    ///   - object: object
    ///   - userInfo: userInfo
    func jk_postNotification(at moduleName:String, notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) -> Void
    
    /// 在一定范围内发送通知
    /// - Parameters:
    ///   - moduleInstance: 模块实例对象
    ///   - notificationName: 通知名字
    func jk_postNotification(at moduleInstance:Any, notificationName:String) -> Void
    
    /// 在一定范围内发送通知
    /// - Parameters:
    ///   - moduleInstance: 模块实例对象
    ///   - notificationName: 通知名字
    ///   - object: object
    ///   - userInfo: userInfo
    func jk_postNotification(at moduleInstance:Any, notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) -> Void
    
    
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
        
        let proxyArr:[JKFastNotificationProxy] = names.compactMap {
            let name:String = $0
            let observered:Bool = tmpSelf.notificationProxyList.contains { proxy in
                return proxy.notificationName == name
            }
            if observered == false {
               return JKFastNotificationProxy(name: name, block: block)
            } else {
                #if DEBUG
                assert(false, "duplicated add observer of the same name!")
                #endif
                return nil
            }
        }
        tmpSelf.notificationProxyList += proxyArr
    }
    
    func jk_observeNotification(at moduleName:String, notificationName:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        jk_observeNotifications(at: moduleName, notificationNames: [notificationName], block: block)
    }
    
    func jk_observeNotifications(at moduleName:String, notificationNames:Array<String>, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        for notificationName in notificationNames {
            let name = "\(moduleName)##$$&&\(notificationName)"
            jk_observeNotificaion(name: name, block: block)
        }
    }
    
    func jk_observeNotification(at moduleInstance:Any, notificationName:String, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        jk_observeNotifications(at: moduleInstance, notificationNames: [notificationName], block: block)
    }
    
    func jk_observeNotifications(at moduleInstance:Any, notificationNames:Array<String>, block:@escaping ((_ notification:Notification) -> Void)) ->Void {
        for notificationName in notificationNames {
            let name = String.init(format: "%p##$$&&%@", moduleInstance as! CVarArg,notificationName)
            jk_observeNotificaion(name: name, block: block)
        }
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
    
    func jk_postNotification(at moduleName:String, notificationName:String) -> Void {
        jk_postNotification(at: moduleName, notificationName: notificationName, object: nil,userInfo: nil)
    }
    
    func jk_postNotification(at moduleName:String, notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) -> Void
    {
        let name = "\(moduleName)##$$&&\(notificationName)"
        jk_postNotification(notificationName: name, object: object, userInfo: userInfo)
    }
    
    func jk_postNotification(at moduleInstance:Any, notificationName:String) -> Void {
        jk_postNotification(at: moduleInstance, notificationName: notificationName, object: nil, userInfo: nil)
    }
    
    func jk_postNotification(at moduleInstance:Any, notificationName:String, object:Any?, userInfo:[AnyHashable : Any]?) -> Void {
        let name = String.init(format: "%p##$$&&%@", moduleInstance as! CVarArg,notificationName)
        jk_postNotification(notificationName: name, object: object, userInfo: userInfo)
        
    }
}

