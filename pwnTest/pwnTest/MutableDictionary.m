//
//  MutableDictionary.m
//  pwnTest
//
//  Created by pwn on 2019/4/23.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "MutableDictionary.h"
#import <objc/runtime.h>

void ExchangeDicMethod(Class oriClass, Class curClass, SEL oriSEL, SEL curSEL)
{
    Method origin_method = class_getInstanceMethod(oriClass, oriSEL);
    Method current_method = class_getInstanceMethod(curClass, curSEL);
    
    if (!origin_method || !current_method) return;
    
    class_replaceMethod(oriClass, curSEL, method_getImplementation(origin_method), method_getTypeEncoding(origin_method));
    class_replaceMethod(oriClass, oriSEL, method_getImplementation(current_method), method_getTypeEncoding(current_method));
}

@implementation MutableDictionary

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeDicMethod(NSClassFromString(@"__NSDictionaryM"), [self class], @selector(setObject:forKey:), @selector(ex_setObject:forKey:));
    });
}

- (void)ex_setObject:(id)obj forKey:(id<NSCopying>)key
{
    if (obj && key) {
        NSLog(@"方法安全执行");
        [self ex_setObject:obj forKey:key];
    } else {
        NSLog(@"setObject:forKey:方法未执行，obj或者key未空");
    }
}

@end
