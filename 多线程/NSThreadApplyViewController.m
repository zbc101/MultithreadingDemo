//
//  NSThreadApplyViewController.m
//  多线程
//
//  Created by zhangbaochuan on 16/10/26.
//  Copyright © 2016年 上海中赢金融信息服务有限公司. All rights reserved.
//

#import "NSThreadApplyViewController.h"

@interface NSThreadApplyViewController ()

@property (nonatomic, strong) UIImageView *myImageView;

@end

@implementation NSThreadApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 375, 500)];
    [self.view addSubview:_myImageView];
    
    
    //开启线程下载图片  这样就不耽误界面的显示了
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 200, 300, 60)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"股票张" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
}

-(void)btnClick:(UIButton *)btn
{
    static float timetag = 0.8;
    CGPoint center = btn.center;
    CGPoint startCenter = center;
    startCenter.y += (1 - timetag)*((self.view.frame.size.height)/2);
    //    cell.center = startCenter;
    
    [UIView animateWithDuration: 0.5 delay: 0.35 usingSpringWithDamping: timetag initialSpringVelocity: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        btn.center = startCenter;
    } completion: ^(BOOL finished){
        btn.center =center;
        timetag = timetag - 0.1;
        if (timetag <= 0.01) {
            timetag = 0.8;
        }
    }];

    NSLog(@"点击了");
}
-(void)downloadImage
{
    //同步下载数据
    NSURL *url=[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1477464688&di=021ccafb5945b8a6d66e26a0f04a9ced&src=http://d.hiphotos.baidu.com/image/pic/item/5882b2b7d0a20cf482c772bf73094b36acaf997f.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    //刷新UI
    //一定要回到主线程
    [self performSelectorOnMainThread:@selector(refreshUI:) withObject:data waitUntilDone:YES];
    
}

//刷新UI
-(void)refreshUI:(NSData *)data
{
    _myImageView.image=[UIImage imageWithData:data];
}




@end
