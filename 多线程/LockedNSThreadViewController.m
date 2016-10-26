//
//  LockedNSThreadViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "LockedNSThreadViewController.h"
#import "MyAccount.h"

@interface LockedNSThreadViewController ()

@property(nonatomic, strong) MyAccount *account;

@end

@implementation LockedNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //账户
    _account=[[MyAccount alloc] initWithAccountname:@"马云" money:20000000];
    
    //创建两个取钱的线程
    NSThread *t1=[[NSThread alloc] initWithTarget:self selector:@selector(threadOne) object:nil];
   // t1.threadPriority = 1;
    t1.name=@"liuhuiyu";
    [t1 start];
    
    NSThread *t2=[[NSThread alloc] initWithTarget:self selector:@selector(threadTwo) object:nil];
    t2.name=@"jingjing";
    [t2 start];
}

-(void)threadOne
{
    [_account withDraw:15000000];
}

-(void)threadTwo
{
    [_account withDraw:15000000];
}


@end
