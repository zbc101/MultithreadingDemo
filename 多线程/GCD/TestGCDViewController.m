//
//  TestGCDViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "TestGCDViewController.h"

@interface TestGCDViewController ()

@end

@implementation TestGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //GCD (grand central dispatcher)大中央调度
    //一.队列
    
    //串行队列
    //前面的线程执行完成,才会开始执行后面的线程
    //并列队列
    //前面加入的线程,与后面加入的线程,同时执行
    
    //1.主线程所在的串行队列
    //是系统自动创建的这个队列,直接使用就行,
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    
    //2.全局的并行队列
    //是系统自动创建的这个队列,直接使用就行,
    // <#long identifier#>,队列的优先级
    // <#unsigned long flags#>:是苹果公司保留的参数,传0就可以
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.自己创建的队列
    //1.串行队列
    //  是队列的标识符,相当于起个名字  ""必须用C语言字符 不能用@""
    // <#dispatch_queue_attr_t attr#> 是用来区分串行还是并行
    //DISPATCH_QUEUE_SERIAL 表示串行队列
    dispatch_queue_t serialQueue=dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //2.并行队列
    //E_CONCURRENT 并行队列
    dispatch_queue_t concurrentQueue=dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //二.使用GCD创建线程
    // <#dispatch_queue_t queue#> 线程执行的队列
    // <#^(void)block#>  线程的执行体
    //1.同步的提交方式  最后提交到并行队列, 串行会卡死
    dispatch_sync(globalQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"线程一:%d",i);
        }
    });
    
    //2.异步的提交方式
    dispatch_async(globalQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"线程二:%d",i);
        }
    });

    
}



@end
