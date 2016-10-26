//
//  MyAccount.h
//  UI5_MyAccount线程锁
//
//  Created by qianfeng on 15/8/7.
//  Copyright (c) 2015年 ZBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccount : NSObject
//自定义
-(instancetype)initWithAccountname:(NSString *)name money:(float)money;


//取钱
-(void)withDraw:(float)money;

@end
