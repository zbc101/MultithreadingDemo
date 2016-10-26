//
//  SyncAndAsyncViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "SyncAndAsyncViewController.h"

@interface SyncAndAsyncViewController ()

@end

@implementation SyncAndAsyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //    [self testSyncWihtSerialQueue];
    //    [self testSyncWithConcurrentQueue];
    //    [self testAsyncWithSerialQueue];
    [self testAsyncWithConcurrentQueue];
    
    
}

//4.异步方式向并行队列提交代码
//前面的线程与后面的线程同时执行88u
-(void)testAsyncWithConcurrentQueue
{
    //创建并行队列
    dispatch_queue_t conQueue=dispatch_queue_create("conQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //线程一
    dispatch_async(conQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程一:%d",i);
        }
    });
    //    线程二
    dispatch_async(conQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程二:%d",i);
        }
    });
}

//3.异步方式向串行队列提交代码
//  都是前面的线程执行完结束后,才开始执行后面的线程
-(void)testAsyncWithSerialQueue
{
    //创建串行队列
    dispatch_queue_t serialQueue=dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //线程一
    dispatch_async(serialQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程一:%d",i);
        }
    });
    
    //    线程二
    dispatch_async(serialQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程二:%d",i);
        }
    });
}


//2.同步方式向并行队列提交代码
//同步方式 的线程   都是前面的线程执行完结束后,才开始执行后面的线程
-(void)testSyncWithConcurrentQueue
{
    //并行队列
    dispatch_queue_t concurrentQueue=dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //线程一
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"并行线程一:%d",i);
        }
    });
    
    //线程二
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"并行线程二:%d",i);
        }
    });
}


//1.同步方式向串行队列提交代码
//前面的线程执行完之后,才会执行后面的线程
-(void)testSyncWihtSerialQueue
{
    //串行队列
    dispatch_queue_t serialQueue=dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //线程一
    dispatch_sync(serialQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程一:%d",i);
        }
    });
    
    //线程二
    dispatch_sync(serialQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"串行线程二:%d",i);
        }
    });
}



@end
