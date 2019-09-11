//
//  NSObject+JKNoticationHelper.h
//  lib
//
//  Created by Demi on 7/10/16.
//  Copyright © 2016 Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFastNotificationProxy.h"

@interface NSObject (JKNoticationHelper)

/**
 监听通知事件。对通知扩展封装，避免循环引用。

 @param name 通知名称
 @param block 通知事件处理
 */
- (void)observeNotificationForName:(NSString *)name usingBlock:(void(^)(NSNotification *notification))block;

/**
 移除通知的监听

 @param name 通知名称
 */
- (void)removeNotification:(NSString *)name;

@end
