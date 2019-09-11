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

- (void)observeNotificationForName:(NSString *)name usingBlock:(JKFastNotificationBlock)block
{
    JKFastNotificationProxy *proxy = [[JKFastNotificationProxy alloc] initWithName:name block:block];
    [[self notificationProxyList] addObject:proxy];
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
