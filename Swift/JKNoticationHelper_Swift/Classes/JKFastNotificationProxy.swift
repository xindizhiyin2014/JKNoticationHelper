//
//  JKFastNotificationProxy.swift
//  JKNoticationHelper_Swift
//
//  Created by JackLee on 2021/9/14.
//

import Foundation
public class JKFastNotificationProxy {

    typealias JKFastNotificationBlock = (Notification) -> Void
    
    var notificationName: String
    var block: JKFastNotificationBlock
    
    init(name: String, block: @escaping JKFastNotificationBlock) {
        self.notificationName = name
        self.block = block
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotifcation(_:)), name: NSNotification.Name.init(notificationName), object: nil)
    }
    
    @objc func receivedNotifcation(_ noti: Notification){
        self.block(noti)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
