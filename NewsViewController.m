//
//  NewsViewController.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "NewsViewController.h"
#import <pop/POP.h>
#import "PaperButton.h"
#import "MenuTableViewCell.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{

    UIScrollView *_customScrollView;
    CGRect currentRect;
    UITableView *customTableView;
    
    NSMutableArray *_carsArr;
    
    UIView *itemView;

}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.title=@"前沿资讯";
    if(!_carsArr)
        _carsArr=[NSMutableArray array];
    _carsArr=[NSMutableArray arrayWithObjects:@"1",@"5",@"2",@"3",@"4",@"5", nil];
    
    
    
    customTableView=[[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+49)) style:(UITableViewStylePlain)];
    customTableView.rowHeight=120;
    customTableView.showsVerticalScrollIndicator=NO;
    customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    customTableView.delegate=self;
    customTableView.dataSource=self;
    [self.view addSubview:customTableView];
    
    
    itemView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    itemView.backgroundColor=[UIColor whiteColor];
    NSArray *arr=@[@"热门话题",@"精彩瞬间",@"比赛",@"精彩博文",@"圈子生活",@"土豪车库"];
    for(int i=0;i<6;i++){
        
        UILabel *lable=[[UILabel alloc] initWithFrame:(CGRectMake(self.view.frame.size.width/2-50, 44*i+30*i,100 , 44))];
        lable.layer.cornerRadius=5.0f;
        lable.layer.masksToBounds=YES;
        lable.font=[UIFont systemFontOfSize:16];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.text=[arr objectAtIndex:i];
        lable.textColor=[UIColor colorWithRed:0.3 green:0.8 blue:0.6 alpha:1.0f];
        [itemView addSubview:lable];
    }
    itemView.hidden=YES;
    [self.view addSubview:itemView];
    
    PaperButton *button = [PaperButton button];
    button.frame=CGRectMake(self.view.frame.size.width-24-15, 10, 24, 17);
    [button addTarget:self action:@selector(animateTitleLabel:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0f];
    [self.navigationController.navigationBar addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)animateTitleLabel:(PaperButton *)sender
{
    [self.view bringSubviewToFront:itemView];
    CGFloat toValue = CGRectGetMidX(self.view.bounds);
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    onscreenAnimation.toValue = @(toValue);
    onscreenAnimation.springBounciness = 10.f;
    
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation easeInAnimation];
    offscreenAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
    offscreenAnimation.toValue = @(-toValue);
    offscreenAnimation.duration = 0.2f;
    
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
    }];
    if(sender.showMenu){
    
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromLeft)];
        itemView.hidden=NO;
    }
        
    else{
    
       [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromLeft)];
        itemView.hidden=YES;
    }
        
}


- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.5f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"cubegrqhgtn"];
}

- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.5f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _carsArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *kcell=@"kcell";
    MenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kcell];
    if(!cell){
        cell=[[MenuTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kcell];
        UIImageView *head=[[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 120))];
        head.tag=101;
        [cell addSubview:head];
    }
    
    UIImageView *hea=(UIImageView *)[cell viewWithTag:101];
    hea.image=[UIImage imageNamed:[_carsArr objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuTableViewCell *cell=(MenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    currentRect=[self.view convertRect:cell.frame fromView:cell.superview];
    
    if(!_customScrollView){
        
        _customScrollView=[[UIScrollView alloc] init];
        _customScrollView.delegate=self;
        [self.view addSubview:_customScrollView];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 120))];
        imageView.tag=102;
        [_customScrollView addSubview:imageView];
        
        
        UITextView *textView=[[UITextView alloc] initWithFrame:(CGRectMake(0, 140, self.view.frame.size.width, 400))];
        textView.font=[UIFont systemFontOfSize:14];
        textView.textColor=[UIColor colorWithRed:0.3 green:0.7 blue:0.6 alpha:1.0f];
        textView.text=@"Lanseer是大帅哥，请大家一起跟我说：Lanseer是最帅的iOS开发工程师。奥迪新一代Q7内饰最直观的变化在于科技感提升了，甚至可以用脱胎换骨来形容，而新车的第三排座椅为选装配置，全景天窗则会成为标配。其他配置方面，新车具有多点气囊、自动驻车、定速巡航以及无钥匙进入等标准配置。此外，新一代Q7还提供四轮转向技术选装，其余选装配置还包括夜视系统、增强型预防式安全系统。动力方面，新一代Q7 40 TFSI搭载的是2.0TFSI发动机，其最大功率为252马力，峰值扭矩369牛·米，而45 TFSI则搭载的是3.0TFSI发动机，最大功率为333马力，峰值扭矩440牛·米。传动方面，与发动机匹配的将是8速手自一体变速箱。此外，新车全系标配四驱系统。（文/汽车之家 兴珉）";
        textView.userInteractionEnabled=NO;
        [_customScrollView addSubview:textView];
        
        UILabel *copyright=[[UILabel alloc] initWithFrame:(CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60))];
        copyright.font=[UIFont systemFontOfSize:16];
        copyright.text=@"Lacar JamsonMax独家版权，请勿转载";
        copyright.textColor=[[UIColor blackColor] colorWithAlphaComponent:0.7f];
        copyright.textAlignment=NSTextAlignmentCenter;
        [_customScrollView addSubview:copyright];
        
        UIPanGestureRecognizer *panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(offScrollView)];
        [_customScrollView addGestureRecognizer:panGes];
        
    }
    _customScrollView.frame=currentRect;
    _customScrollView.backgroundColor=[cell.backgroundColor colorWithAlphaComponent:1.0f];
    _customScrollView.showsHorizontalScrollIndicator=NO;
    _customScrollView.showsVerticalScrollIndicator=NO;
    [self.view bringSubviewToFront:_customScrollView];
    UIImageView *imageView=(UIImageView *)[_customScrollView viewWithTag:102];
    imageView.image=[UIImage imageNamed:[_carsArr objectAtIndex:indexPath.row]];
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height)];
    scaleAnimation.springBounciness = 5.f;
    [scaleAnimation setSpringSpeed:10];
    [_customScrollView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)offScrollView{
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    scaleAnimation.toValue = [NSValue valueWithCGRect:currentRect];
    scaleAnimation.springBounciness = 5.f;
    [scaleAnimation setSpringSpeed:10];
    [_customScrollView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL flag) {
        if(flag)
            [self.view bringSubviewToFront:customTableView];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {
    
    [self.view bringSubviewToFront:customTableView];
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
