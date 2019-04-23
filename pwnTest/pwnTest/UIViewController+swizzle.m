//
//  UIViewController+swizzle.m
//  pwnTest
//
//  Created by pwn on 2019/4/22.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "UIViewController+swizzle.h"
#import <objc/runtime.h>



@implementation UIViewController (swizzle)

void MethodSwizzle(Class c, SEL oriSEL, SEL overrideSEL)
{
    Method originMethod = class_getInstanceMethod(c, oriSEL);
    Method swizzleMethod = class_getInstanceMethod(c, overrideSEL);
    
    BOOL did_add_method = class_addMethod(c, oriSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));//添加Method，其键值为originSelector，值为swizzleMethod的实现
    
    if (did_add_method) {
        NSLog(@"debugMsg: ViewController类中没有viewDidLoad方法(可能在其父类h中)，所以先添加后替换");
        class_replaceMethod(c, overrideSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        NSLog(@"debugMsg: 直接交换方法");
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        MethodSwizzle([self class], @selector(viewDidLoad), @selector(wn_viewDidLoad));
        
    });
}

- (void)wn_viewDidLoad
{
    NSLog(@"调用了wn_viewDidLoad");
    [self wn_viewDidLoad];
}

@end
