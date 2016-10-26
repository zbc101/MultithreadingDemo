//
//  GCDDemoViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "GCDDemoViewController.h"

@interface GCDDemoViewController ()

@end

@implementation GCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 80)];
    [self.view addSubview:imageView];
    
    //下载图片
    //全局的并行队列
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //开辟线程
    dispatch_async(globalQueue, ^{
        //下载数据
        NSString *urlString=@"http://g.hiphotos.baidu.com/image/pic/item/4034970a304e251fb3145e6ca586c9177e3e5346.jpg";
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        //const char *p
        //char * const p;
        
        //回到主线程修改UI
        dispatch_queue_t mainQueue=dispatch_get_main_queue();
        
        dispatch_async(mainQueue, ^{
            imageView.image=[UIImage imageWithData:data];
            imageView.frame=CGRectMake(0, 0, 375, 500);//imageView不能变,但是imageView.frame等是可以变的
        });
    });

}



@end
