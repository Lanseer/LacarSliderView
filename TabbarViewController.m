//
//  TabbarViewController.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "TabbarViewController.h"
#import "NewsViewController.h"
#import "CircleViewController.h"
#import "GarageViewController.h"

#import "ContainerViewController.h"
@interface TabbarViewController ()

@end

@implementation TabbarViewController
@synthesize tabVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabVC = [[UITabBarController alloc] init];
    self.tabVC.tabBar.hidden=YES;
    [self.view addSubview:self.tabVC.view];
    
    
    [self createViewControllers ];
    
    
    // Do any additional setup after loading the view.
}

- (void)createViewControllers{

    //资讯
    
    NewsViewController *news=[[NewsViewController alloc] init];
    UINavigationController *newsNavi=[[UINavigationController alloc] initWithRootViewController:news];
    
    
    //汽车圈子
    
    CircleViewController *circle=[[CircleViewController alloc] init];
    UINavigationController *circleNavi=[[UINavigationController  alloc] initWithRootViewController:circle];
    
    //个人车库
    
    GarageViewController *garage=[[GarageViewController alloc] init];
    UINavigationController *garageNavi=[[UINavigationController alloc] initWithRootViewController:garage];
    
    self.tabVC.viewControllers=@[newsNavi,circleNavi,garageNavi];
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
