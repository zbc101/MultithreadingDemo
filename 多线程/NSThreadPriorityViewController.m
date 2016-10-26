//
//  NSThreadPriorityViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/25.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "NSThreadPriorityViewController.h"

@interface NSThreadPriorityViewController ()

@end

@implementation NSThreadPriorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSThread *t1=[[NSThread alloc] initWithTarget:self selector:@selector(createThreadOne) object:nil];
    t1.name=@"线程A";
    t1.threadPriority=0;
    [t1 start];
    
    NSThread *t2=[[NSThread alloc] initWithTarget:self selector:@selector(createThreadTwo) object:nil];
    t2.name=@"线程B";
    
    //修改优先级  值越大优先级越高
    //0.0到1.0的double类型，1.0为最高优先级 当大于1时 测试下，跟1一样
    t2.threadPriority=3;
    t2.qualityOfService = NSQualityOfServiceBackground;
    
    [t2 start];
    
}

-(void)createThreadOne
{
    for (int i=0; i<100; i++) {
        NSLog(@"执行了=%@:%d",[NSThread currentThread].name,i);
    }
    //    [t2 start];
}
-(void)createThreadTwo
{
    for (int i=0; i<100; i++) {
        NSLog(@"执行了=%@:%d",[NSThread currentThread].name,i);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
