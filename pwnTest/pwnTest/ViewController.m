//
//  ViewController.m
//  pwnTest
//
//  Created by pwn on 2019/4/22.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "ViewController.h"
#import "Animals.h"
#import "UIButton+QuickClick.h"

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Animals *animal = [[Animals alloc] init];
    [animal eat:@"dogFood"];
    [animal eat:@"pigFood"];
    
    [Animals run:11];
    [Animals run:7];
    
    NSMutableDictionary *mulDic = [NSMutableDictionary dictionary];
    [mulDic setObject:@"value" forKey:@"someKey"];
    [mulDic setObject:nil forKey:@"anoKey"];
    NSLog(@"");
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.delayTime = 3;
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click
{
    NSLog(@"点击了按钮");
}


@end
