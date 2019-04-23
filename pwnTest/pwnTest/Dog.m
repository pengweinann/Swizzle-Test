//
//  Dog.m
//  pwnTest
//
//  Created by pwn on 2019/4/23.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

void SwizzleMethod(Class oriClass, Class overClass, SEL oriSEL, SEL overSEL)
{
    Method origin_method = class_getInstanceMethod(oriClass, oriSEL);
    Method swizzle_method = class_getInstanceMethod(overClass, overSEL);
    
    //判断oriClass是否已经存在overSEL方法，若已存在，则return
    BOOL exit_overSel = class_addMethod(oriClass, overSEL, method_getImplementation(swizzle_method), method_getTypeEncoding(swizzle_method));
    if (!exit_overSel) return;
    
    //获取oriClass的overSEL的Method实例
    swizzle_method = class_getInstanceMethod(oriClass, overSEL);
    if (!swizzle_method) return;
    
    BOOL exit_origin = class_addMethod(oriClass, oriSEL, method_getImplementation(swizzle_method), method_getTypeEncoding(swizzle_method));
    if (exit_origin) {
        class_replaceMethod(oriClass, overSEL, method_getImplementation(origin_method), method_getTypeEncoding(origin_method));
    } else {
        method_exchangeImplementations(origin_method, swizzle_method);
    }
    
}

@implementation Dog

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethod(NSClassFromString(@"Animals"), [self class], NSSelectorFromString(@"eat:"), NSSelectorFromString(@"dog_eat:"));
    });
}

- (void)dog_eat:(NSString *)food
{
    if ([food isEqualToString:@"dogFood"]) {
        [self dog_eat:food];
    } else {
        NSLog(@"不是狗粮");
    }
}

@end
