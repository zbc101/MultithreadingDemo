//
//  ImageOperation.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "ImageOperation.h"


@implementation ImageOperation

//线程执行体
-(void)main
{
    //下载数据
    NSURL *url=[NSURL URLWithString:self.urlString];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    //self.imageView.image=[UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(refreshUI:) withObject:data waitUntilDone:YES];
}

-(void)refreshUI:(NSData *)data
{
    self.imageView.image=[UIImage imageWithData:data];
}


@end
