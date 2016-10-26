//
//  BaseViewController.h
//  fxdProduct
//
//  Created by dd on 15/7/31.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITabBarControllerDelegate,UITabBarDelegate>


- (void)setNavMesRightBar;

- (void)setNavCallRightBar;

- (void)setNavSignLeftBar;

- (void)addBackItem;

- (void)addBackRootItem;

@end
