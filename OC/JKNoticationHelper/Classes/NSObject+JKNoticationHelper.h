//
//  NSObject+JKNoticationHelper.h
//  lib
//
//  Created by Demi on 7/10/16.
//  Copyright © 2016 Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFastNotificationProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JKNoticationHelper)

/**
 监听通知事件。对通知扩展封装，避免循环引用。

 @param name 通知名称
 @param block 通知事件处理
 */
- (void)jk_observeNotificationForName:(NSString *)name
                           usingBlock:(void(^)(NSNotification *notification))block;

/// 监听一组通知事件
/// @param names 通知名称数组
/// @param block 通知事件处理
- (void)jk_observeNotificationForNames:(NSArray<NSString *> *)names
                            usingBlock:(void(^)(NSNotification *notification))block;

/// 在一定范围内监听通知事件
/// @param moduleName 模块名
/// @param name 通知名字
/// @param block 通知事件处理
- (void)jk_observeNotificationAtModule:(NSString *)moduleName
                               forName:(NSString *)name
                            usingBlock:(void(^)(NSNotification *notification))block;

/// 在一定范围内监听一组通知事件
/// @param moduleName 模块名
/// @param names 通知名称数组
/// @param block 通知事件处理
- (void)jk_observeNotificationAtModule:(NSString *)moduleName
                              forNames:(NSArray<NSString *> *)names
                            usingBlock:(void(^)(NSNotification *notification))block;

/// 在一定范围内监听通知事件
/// @param moduleInstance 模块实例对象
/// @param name 通知名字
/// @param block 通知事件处理
- (void)jk_observeNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                                       forName:(NSString *)name
                                    usingBlock:(void(^)(NSNotification *notification))block;

/// 在一定范围内监听一组通知事件
/// @param moduleInstance 模块实例对象
/// @param names 通知名称数组
/// @param block 通知事件处理
- (void)jk_observeNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                                      forNames:(NSArray<NSString *> *)names
                                    usingBlock:(void(^)(NSNotification *notification))block;


/// 发送通知
/// @param name 通知的名字
- (void)jk_postNotification:(NSString *)name;

/// 发送通知
/// @param name 通知的名字
/// @param object object
/// @param userInfo userInfo
- (void)jk_postNotification:(NSString *)name
                     object:(nullable id)object
                   userInfo:(nullable NSDictionary *)userInfo;

/// 在一定范围内发送通知
/// @param moduleName 模块名
/// @param notificationName 通知的名字
- (void)jk_postNotificationAtModule:(NSString *)moduleName
                   notificationName:(NSString *)notificationName;

/// 在一定范围内发送通知
/// @param moduleName 模块名
/// @param notificationName 通知的名字
/// @param object object
/// @param userInfo userInfo
- (void)jk_postNotificationAtModule:(NSString *)moduleName
                   notificationName:(NSString *)notificationName
                             object:(nullable id)object
                           userInfo:(nullable NSDictionary *)userInfo;

/// 在一定范围内发送通知
/// @param moduleInstance 模块实例对象
/// @param notificationName 通知的名字
- (void)jk_postNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                           notificationName:(NSString *)notificationName;

/// 在一定范围内发送通知
/// @param moduleInstance 模块实例对象
/// @param notificationName 通知的名字
/// @param object object
/// @param userInfo userInfo
- (void)jk_postNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                           notificationName:(NSString *)notificationName
                                     object:(nullable id)object
                                   userInfo:(nullable NSDictionary *)userInfo;

/**
 移除通知的监听

 @param name 通知名称
 */
- (void)removeNotification:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
