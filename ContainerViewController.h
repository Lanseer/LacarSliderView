//
//  ContainerViewController.h
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

+(ContainerViewController *)sharedContainerVC;
- (void)closeLeftMenuWithItem :(NSInteger)item;
- (void)openLeftMenu;
@end
