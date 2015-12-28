//
//  GarageViewController.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "GarageViewController.h"

@interface GarageViewController ()

@end

@implementation GarageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人车库";
    UIImageView *iamge=[[UIImageView alloc] initWithFrame:self.view.frame];
    iamge.image=[UIImage imageNamed:@"garage"];
    iamge.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:iamge];
    // Do any additional setup after loading the view.
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
