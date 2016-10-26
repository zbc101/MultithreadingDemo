//
//  NSOperationQueueViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "NSOperationQueueViewController.h"

@interface NSOperationQueueViewController ()

@end

@implementation NSOperationQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建一个对列
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    //队列中最多执行几个线程
    queue.maxConcurrentOperationCount=3;
    
    //第一种方式
    NSNumber *n=@100;
    NSInvocationOperation *op1=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(threadOne:) object:n];
    
    //completion 完成
    [op1 setCompletionBlock:^{
        NSLog(@"线程一结束");
    }];
    
    //添加到队列
    [queue addOperation:op1];
    
    
    //第二种方式
    NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
        //线程的执行体
        for (int i=0; i<100; i++) {
            NSLog(@"执行了线程二:%d",i);
        }
        
    }];
    
    op2.completionBlock=^{
        NSLog(@"线程二结束");
    };
    //必须要添加到队列 要不不能用
    [queue addOperation:op2];

    
}

-(void)threadOne:(NSNumber *)n
{
    for (int i=0; i<n.intValue; i++) {
        NSLog(@"执行线程一:%d",i);
    }
}

@end
