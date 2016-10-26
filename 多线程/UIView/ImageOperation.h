//
//  ImageOperation.h
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageOperation : NSOperation

//下载链接
@property(nonatomic,strong)NSString *urlString;

//图片视图
@property(nonatomic,strong)UIImageView *imageView;

@end
