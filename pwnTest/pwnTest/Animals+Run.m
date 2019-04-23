//
//  Animals+Run.m
//  pwnTest
//
//  Created by pwn on 2019/4/23.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "Animals+Run.h"
#import <objc/runtime.h>

void ExchangeMethod(Class class, SEL oriSEL, SEL exchangeSEL)
{
    Method origin_method = class_getClassMethod(class, oriSEL);
    Method exchange_method = class_getClassMethod(class, exchangeSEL);
    
    if (!origin_method || !exchange_method) return;
    IMP origin_imp = method_getImplementation(origin_method);
    IMP swizzle_imp = method_getImplementation(exchange_method);
    
    const char *origin_type= method_getTypeEncoding(origin_method);
    const char *swizzle_type = method_getTypeEncoding(exchange_method);
    
    Class metaClass = objc_getMetaClass(class_getName(class));
    class_replaceMethod(metaClass, oriSEL, swizzle_imp, swizzle_type);
    class_replaceMethod(metaClass, exchangeSEL, origin_imp, origin_type);
}

@implementation Animals (Run)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeMethod([self class], @selector(run:), @selector(ex_run:));
    });
}

+ (void)ex_run:(NSInteger)kilo
{
    if (kilo >= 10) {
        [self ex_run:kilo];
    } else {
        NSLog(@"失败了！！=_= ，只跑了%ld kilo",kilo);
    }
}

@end
