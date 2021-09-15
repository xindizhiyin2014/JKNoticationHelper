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
        [[self notificationProxyList] addObject:proxy];
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
