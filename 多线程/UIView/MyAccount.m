//
//  MyAccount.m
//  UI5_MyAccount线程锁
//
//  Created by qianfeng on 15/8/7.
//  Copyright (c) 2015年 ZBC. All rights reserved.
//

#import "MyAccount.h"


@implementation MyAccount
{
    NSString *_name;
    float _money;
    
    NSLock *_myLock;
}

-(instancetype)initWithAccountname:(NSString *)name money:(float)money
{
    if (self=[super init]) {
        _name=name;
        _money=money;
        _myLock=[[NSLock alloc] init];
    }
    
    return self;
}

-(void)withDraw:(float)money
{
    //加锁
    
//    [_myLock lock];
    @synchronized(self){
        
        if (_money>=money) {
            //线程睡眠
            [NSThread sleepForTimeInterval:0.01];
            
            _money-=money;
            NSLog(@"%@取了==%.2f",[NSThread currentThread].name,money);
        }else{
            NSLog(@"余额不足");
        }
    }
    
//    [_myLock unlock];
}

@end
