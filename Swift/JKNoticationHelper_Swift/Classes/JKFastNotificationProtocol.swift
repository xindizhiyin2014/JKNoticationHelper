//
//  JKFastNotificationProtocol.swift
//  JKNoticationHelper_Swift
//
//  Created by JackLee on 2021/9/8.
//

import Foundation
public protocol JKFastNotificationProtocol {
    
    /// 添加通知的监听
    /// - Parameters:
    ///   - name: 通知的名字
    ///   - block: 处理通知的回调
    func jk_observe(name:String, block:((_ notification:Notification) -> Void))
    
    /// 添加一组通知的监听
    /// - Parameters:
    ///   - names: 通知的名字组成的数组
    ///   - block: 处理通知的回调
    func jk_observe(names:Array<String>,block:((_ notification:Notification) -> Void))
    
    /// 移除通知的监听
    /// - Parameter name: 通知的名字
    func jk_removeObserve(for name:String)

}

public extension JKFastNotificationProtocol {
    func jk_observe(name:String, block:((_ notification:Notification) -> Void)) -> Void {
        jk_observe(names: [name], block: block)
    }
    
    func jk_observe(names:Array<String>,block:@escaping ((_ notification:Notification) -> Void)) -> Void {
        for name in names {
            NotificationCenter.default.addObserver(forName: Notification.Name.init(name), object: nil, queue: nil, using: block)
        }
    }
    
    func jk_removeObserve(for name:String) ->Void {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.init(name), object: nil)
    }
}
