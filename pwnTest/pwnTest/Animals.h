//
//  Animals.h
//  pwnTest
//
//  Created by pwn on 2019/4/23.
//  Copyright © 2019 pwn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animals : NSObject

- (void)eat:(NSString *)food;

+ (void)run:(NSInteger)kilo;

@end


NS_ASSUME_NONNULL_END
