//
//  TDFastNotificationProxy.h
//  lib
//
//  Created by Demi on 7/10/16.
//  Copyright © 2016 Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JKFastNotificationBlock)(NSNotification *notification);

@interface JKFastNotificationProxy : NSObject

@property (nonatomic, readonly, copy) NSString *notificationName;
@property (nonatomic, readonly, copy) JKFastNotificationBlock block;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithName:(NSString *)name block:(JKFastNotificationBlock)block;


@end
