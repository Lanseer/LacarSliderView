//
//  LeftMenuViewController.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ContainerViewController.h"
#import "ContainerViewController.h"
#import "MenuTableViewCell.h"
@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSArray *_titleArr;
}
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr=@[@"   前沿资讯",@"   汽车圈子",@"   个人车库"];
    
    UIImageView *headImage=[[UIImageView alloc] initWithFrame:(CGRectMake(25, 54, 80, 80))];
    headImage.image=[UIImage imageNamed:@"IMG_1158.JPG"];
    headImage.layer.cornerRadius=40;
    headImage.layer.masksToBounds=YES;
    [self.view addSubview:headImage];
    
    UILabel *ps=[[UILabel alloc] initWithFrame:(CGRectMake(25, headImage.frame.origin.y+80+20, 400, 16))];
    ps.backgroundColor=[UIColor clearColor];
    ps.font=[UIFont systemFontOfSize:16];
    ps.textColor=[UIColor whiteColor];
    ps.text=@"LACAR，最专业的汽车平台";
    [self.view addSubview:ps];
    
    UILabel *name=[[UILabel alloc] initWithFrame:(CGRectMake(125, headImage.frame.origin.y+40, 400, 16))];
    name.backgroundColor=[UIColor clearColor];
    name.font=[UIFont systemFontOfSize:16];
    name.textColor=[UIColor whiteColor];
    name.text=@"辣车库";
    [self.view addSubview:name];

    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width*0.60, 240)style:(UITableViewStylePlain)];
    
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.rowHeight=80;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tableView];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *kcell=@"kcell";
    MenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kcell];
    if(!cell){
    
        cell=[[MenuTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kcell];
    }
    
    cell.textLabel.text=[_titleArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone   ;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[ContainerViewController sharedContainerVC] closeLeftMenuWithItem:indexPath.row];
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
