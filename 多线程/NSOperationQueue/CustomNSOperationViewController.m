//
//  CustomNSOperationViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "CustomNSOperationViewController.h"
#import "ImageOperation.h"

@interface CustomNSOperationViewController ()

@end

@implementation CustomNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //图片视图
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 355, 470)];
    
    [self.view addSubview:imageView];
    
    //创建线程下载
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    ImageOperation *op=[[ImageOperation alloc] init];
    op.urlString=@"http://pic9.nipic.com/20100904/4845745_195609329636_2.jpg";
    
    op.imageView=imageView;
    
    [queue addOperation:op];
}



@end
