//
//  Animals.m
//  pwnTest
//
//  Created by pwn on 2019/4/23.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "Animals.h"

@implementation Animals

- (void)eat:(NSString *)food
{
    NSLog(@"food Name = %@",food);
}

+ (void)run:(NSInteger)kilo
{
    NSLog(@"胜利了！！跑了 %ld kilo",(long)kilo);
}

@end
