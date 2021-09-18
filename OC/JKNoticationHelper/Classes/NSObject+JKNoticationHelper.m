//
//  NSObject+JKNoticationHelper.m
//  lib
//
//  Created by Demi on 7/10/16.
//  Copyright © 2016 Taylor. All rights reserved.
//

#import "NSObject+JKNoticationHelper.h"
#import <objc/runtime.h>
#import "JKFastNotificationProxy.h"

static const void *kProxyList = &kProxyList;

@implementation NSObject (JKNoticationHelper)

- (NSMutableArray *)notificationProxyList
{
    NSMutableArray *list = objc_getAssociatedObject(self, kProxyList);
    if (!list)
    {
        list = [NSMutableArray array];
        objc_setAssociatedObject(self, kProxyList, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return list;
}

- (void)jk_observeNotificationForName:(NSString *)name
                           usingBlock:(void(^)(NSNotification *notification))block
{
    if (name) {
        [self jk_observeNotificationForNames:@[name] usingBlock:block];
    } else {
#if DEBUG
        NSAssert(NO, @"name can't be nil");
#endif
    }
}

- (void)jk_observeNotificationForNames:(NSArray<NSString *> *)names
                            usingBlock:(void(^)(NSNotification *notification))block
{
    for (NSString *name in names) {
        JKFastNotificationProxy *proxy = [[JKFastNotificationProxy alloc] initWithName:name block:block];
        NSArray *notificationProxyList = [self notificationProxyList];
        BOOL isContained = NO;
        for (JKFastNotificationProxy *tempProxy in notificationProxyList) {
            if ([tempProxy.notificationName isEqualToString:proxy.notificationName]) {
#if DEBUG
                NSAssert(NO, @"duplicated add observer of the same name!");
#endif
                isContained = YES;
                break;
            }
        }
        if (!isContained) {
            [[self notificationProxyList] addObject:proxy];
        }
    }
}

- (void)jk_observeNotificationAtModule:(NSString *)moduleName
                               forName:(NSString *)name
                            usingBlock:(void(^)(NSNotification *notification))block
{
    if (name) {
        [self jk_observeNotificationAtModule:moduleName forNames:@[name] usingBlock:block];
    } else {
#if DEBUG
        NSAssert(NO, @"name can't be nil");
#endif
    }
}

- (void)jk_observeNotificationAtModule:(NSString *)moduleName
                              forNames:(NSArray<NSString *> *)names
                            usingBlock:(void(^)(NSNotification *notification))block
{
    if (moduleName && names) {
        for (NSString *notificationName in names) {
            NSString *name = [NSString stringWithFormat:@"%@##$$&&%@",moduleName,notificationName];
            [self jk_observeNotificationForName:name usingBlock:block];
        }
    } else {
#if DEBUG
        NSAssert(NO, @"moduleName and names can't be nil");
#endif
    }
}

- (void)jk_observeNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                                       forName:(NSString *)name
                                    usingBlock:(void(^)(NSNotification *notification))block
{
    if (name) {
        [self jk_observeNotificationAtModuleInstance:moduleInstance forNames:@[name] usingBlock:block];
    } else {
#if DEBUG
        NSAssert(NO, @"name can't be nil");
#endif
    }
}

- (void)jk_observeNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                                      forNames:(NSArray<NSString *> *)names
                                    usingBlock:(void(^)(NSNotification *notification))block
{
    if (moduleInstance && names) {
        for (NSString *notificationName in names) {
            NSString *name = [NSString stringWithFormat:@"%p##$$&&%@",moduleInstance,notificationName];
            [self jk_observeNotificationForName:name usingBlock:block];
        }
    } else {
#if DEBUG
        NSAssert(NO, @"moduleInstance and names can't be nil");
#endif
    }
}

- (void)jk_postNotification:(NSString *)name
{
    [self jk_postNotification:name object:nil userInfo:nil];
}

- (void)jk_postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

- (void)jk_postNotificationAtModule:(NSString *)moduleName
                   notificationName:(NSString *)notificationName
{
    [self jk_postNotificationAtModule:moduleName notificationName:notificationName object:nil userInfo:nil];
}

- (void)jk_postNotificationAtModule:(NSString *)moduleName
                   notificationName:(NSString *)notificationName
                             object:(nullable id)object
                           userInfo:(nullable NSDictionary *)userInfo
{
    if (moduleName
        && notificationName) {
        NSString *name = [NSString stringWithFormat:@"%@##$$&&%@",moduleName,notificationName];
        [self jk_postNotification:name object:object userInfo:userInfo];
    } else {
#if DEBUG
        NSAssert(NO, @"moduleName and notificationName can't be nil!");
#endif
    }
}

- (void)jk_postNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                           notificationName:(NSString *)notificationName
{
    [self jk_postNotificationAtModuleInstance:moduleInstance notificationName:notificationName object:nil userInfo:nil];
}

- (void)jk_postNotificationAtModuleInstance:(__kindof NSObject *)moduleInstance
                           notificationName:(NSString *)notificationName
                                     object:(nullable id)object
                                   userInfo:(nullable NSDictionary *)userInfo
{
    if (moduleInstance
        && notificationName) {
        NSString *name = [NSString stringWithFormat:@"%p##$$&&%@",moduleInstance,notificationName];
        [self jk_postNotification:name object:object userInfo:userInfo];
    } else {
#if DEBUG
        NSAssert(NO, @"moduleInstance and notificationName can't be nil!");
#endif
    }
}


- (void)removeNotification:(NSString *)name
{
    @synchronized (self) {
        NSMutableArray *originProxys = [self notificationProxyList];
        NSMutableArray *prxoys = [NSMutableArray array];
        for (JKFastNotificationProxy *proxy in originProxys) {
            if (![proxy.notificationName isEqualToString:name]) {
                [prxoys addObject:proxy];
            }
        }
        if (originProxys.count > 0) {
            objc_setAssociatedObject(self, kProxyList, prxoys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

@end
