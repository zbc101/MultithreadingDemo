//
//  RootViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/21.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "WhyUserThreadViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleArr = @[@"一、为什么要使用多线程",@"二、NSThread两种方式创建多线程和取消",@"三、NSThread优先级"
                  ,@"四、线程锁",@"五、NSThread应用",@"六、NSOperationTest",@"七、CustomOPeration"
                  ,@"八、TestGCD",@"九、GCD同步异步区别",@"十、GCDDemoDownloadImage"
                  ,@"10、TestGCDMore"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellind";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictAction = [self inputActions];
    Class classViews=NSClassFromString(dictAction[@(indexPath.row)]);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIViewController *uvc=[[classViews alloc] init];
    
    [self.navigationController pushViewController:uvc animated:YES];
}


- (NSDictionary *)inputActions
{
    static NSDictionary *actions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions = @{@(0) : @"WhyUserThreadViewController",
                    @(1) : @"CreateThreadViewController",
                    @(2) : @"NSThreadPriorityViewController",
                    @(3) : @"LockedNSThreadViewController",
                    @(4) : @"NSThreadApplyViewController",
                    @(5) : @"NSOperationQueueViewController",//NSOperationQueue
                    @(6) : @"CustomNSOperationViewController",
                    @(7) : @"TestGCDViewController",
                    @(8) : @"SyncAndAsyncViewController",
                    @(9) : @"GCDDemoViewController",
                    @(10): @"TestGCDMoreViewController"
                    };
    });
    return actions;
}

@end
