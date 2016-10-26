//
//  CreateThreadViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/21.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "CreateThreadViewController.h"

@interface CreateThreadViewController ()
{
    BOOL _isThreadCancel;
}
@end

@implementation CreateThreadViewController

//两种方式创建多线程

//initWithTarget:(id)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _isThreadCancel = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(50, 300, 100, 40);
    [btn addTarget:self action:@selector(btnC) forControlEvents:UIControlEventTouchUpInside];
    //第一种方式
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame=CGRectMake(50, 100, 100, 40);
    [btn1 setTitle:@"方式一" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(threadOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame=CGRectMake(50, 200, 100, 40);
    [btn2 setTitle:@"方式二" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(threadTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听线程的退出
    //注册通知
    //使用系统SDK里面的通知,只需要注册就行了,不需要自己发送通知
    //系统会在对应的时刻发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threadWillExit:) name:NSThreadWillExitNotification object:nil];
    
}

//接收到通知时  执行的方法
-(void)threadWillExit:(NSNotification *)n
{
    NSThread *t=n.object;
    NSString *name=t.name;
    
    NSLog(@"线程退出了2=%@",name);
}

-(void)dealloc{
    NSLog(@"移除通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)btnC
{
    NSLog(@"测试");
}

//第一种方式:
//创建了新线程  他不影响主线程的操作, 解决了界面假死的方式
-(void)threadOne:(id)btn
{
    //
    NSNumber *n=@30;
    //    @100=[NSNumber numberWithInt:100]
    //创建并启动一个线程  detach  使…分开  挣脱
 //   [NSThread detachNewThreadSelector:@selector(createOne:) toTarget:self withObject:n];
    [NSThread detachNewThreadWithBlock:^{
        [self createOne:n];
    }];
    
}
//线程的操作,与实现的方法
-(void)createOne:(NSNumber *)n
{
    for(int i=0;i<n.intValue;i++)
    {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"执行一个线程一:%d",i);
    }
    _isThreadCancel = YES;
}

//第二种方式
-(void)threadTwo:(id)btn
{
    //    NSLog(@"进入button了");
    
    NSNumber *n=@50;
    //创建了一个线程 兵没有启动
    NSThread *t=[[NSThread alloc] initWithTarget:self selector:@selector(createTwo:) object:n];
    //线程的名字 点语法set 方法
    t.name=@"线程B";
    //    [t setName:@"线程B"]
    [t start];
}

-(void)createTwo:(NSNumber *)n
{
    //修改当前线程的名字
    [NSThread currentThread].name=@"线程A";
    
    for (int i=0; i<n.intValue;i++) {
        //        NSThread *t=[NSThread currentThread];
        //        [t name];
        NSLog(@"执行第二个线程:%@=%d",[NSThread currentThread].name,i);
        if (_isThreadCancel) {
            NSLog(@"NSThread currentThread = %@",[NSThread currentThread].name);
            [NSThread exit];
        }
    }
    
}


@end
