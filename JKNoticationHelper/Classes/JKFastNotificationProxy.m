//
//  JKFastNotificationProxy.m
//  lib
//
//  Created by Demi on 7/10/16.
//  Copyright © 2016 Taylor. All rights reserved.
//

#import "JKFastNotificationProxy.h"

@interface JKFastNotificationProxy ()

@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, copy) JKFastNotificationBlock block;

@end

@implementation JKFastNotificationProxy

- (instancetype)initWithName:(NSString *)name block:(JKFastNotificationBlock)block
{
    self = [super init];
    if (self)
    {
        self.notificationName = name;
        self.block = block;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivedNotifcation:)
                                                     name:_notificationName
                                                   object:nil];
    }
    return self;
}

- (void)receivedNotifcation:(NSNotification *)note
{
    if (_block)
    {
        _block(note);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_notificationName object:nil];
}

@end
