//
//  WhyUserThreadViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/21.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "WhyUserThreadViewController.h"

@interface WhyUserThreadViewController ()

@end

@implementation WhyUserThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //按钮一.执行一个耗时的操作,网络请求,或数据库查询
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 40)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"按钮一" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    //按钮
    //添加点击事件
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame=CGRectMake(50, 200, 100, 40);
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 setTitle:@"点击" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ctLicek) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    
}


-(void)btnClick
{
    //在主线程执行比较耗时的操作,会产出界面假死的情况,
    //所有针对比较耗时的操作,比如网络下载,数据库操作
    //都应该放到另外的线程
    
    //ISO中UI的操作 只能在主线程执行
    for (int i=0; i<10; i++) {
        [NSThread sleepForTimeInterval:1];//线程休眠1秒
    }
}
//会有页面假死的状态
-(void)ctLicek
{
    NSLog(@"点击了第二个按钮");
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
