//
//  TestGCDMoreViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "TestGCDMoreViewController.h"

@interface TestGCDMoreViewController ()

@end

@implementation TestGCDMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 380, 300, 60)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
     //   [self testApply];
    //    [self testOnce];
    //    [self testAfter];
        [self testGroup];
    //    [self testBarrier];
}

-(void)btnClick
{
    NSLog(@"sjlsgjlsgj");
}
//5.在两个线程序列之间执行一段代码
-(void)testBarrier
{
    //队列不能是系统的全局并行队列,要用自己创建的
    dispatch_queue_t conQueue=dispatch_queue_create("conQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //线程一
    dispatch_async(conQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"线程一:%d",i);
        }
    });
    
    //线程二
    dispatch_async(conQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"线程二:%d",i);
        }
    });
    //在线程一.线程二执行完成之后,在线程三执行之前执行一段代码
    dispatch_barrier_async(conQueue, ^{
        NSLog(@"barrier");
    });
    
    //线程三
    dispatch_async(conQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"线程三:%d",i);
        }
    });
    
    
    
}

//4.将线程放到一个组里面
-(void)testGroup
{
    //创建一个组
    dispatch_group_t group=dispatch_group_create();
    
    //创建队列
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //<#dispatch_group_t group#> 线程所在的组
    //<#dispatch_queue_t queue#> 线程所在的队列
    //<#^(void)block#>  线程的执行体
    //线程一
    dispatch_group_async(group, globalQueue, ^{
        for (int i=0; i<100; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"线程一:%d",i);
        }
    });
    //线程二
    dispatch_group_async(group, globalQueue, ^{
        for (int i=0; i<100; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"线程二:%d",i);
        }
    });
    
    //在线程组里面的所有线程执行完之后调用的代码
    dispatch_group_notify(group, globalQueue, ^{
        NSLog(@"线程组执行完成");
    });
}

//3.代码快在一段时间后执行
-(void)testAfter
{
    NSLog(@"执行之前");
    //时间
    //当前时间10s之后
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*10);
    
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"执行了after");
    });
}


//2.代码块只执行一次,单例中应用比较多
-(void)testOnce
{
    //static 还是需要加的 要不人会有问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
        NSLog(@"执行一次");
    });
    NSLog(@"%ld",onceToken);
}

//1.多次执行相同的代码块
-(void)testApply
{
    //<#size_t iterations#> 代码块执行的次数
    //<#dispatch_queue_t queue#>代码块所在的队列
    //<#^(size_t)block#> 代码块的内容
    size_t t=1000;
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(t, globalQueue, ^(size_t time) {
       // [NSThread sleepForTimeInterval:1];
        NSLog(@"第%ld次",time);
    });

}


@end
