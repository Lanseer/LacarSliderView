//
//  ContainerViewController.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/9.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "ContainerViewController.h"
#import "TabbarViewController.h"
#import "LeftMenuViewController.h"
#import <pop/Pop.h>


#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height
#define kSpringBounciness 10
#define  kSpringSpeed 20


//当前显示状态：是否打开左菜单
typedef enum menuState{

    closeLeftMenu,
    openLeftMenu

}menuState;

static const CGFloat slideViewScale = 0.70;
static const CGFloat viewScaleForHeight = 0.80;
static const CGFloat kSlideScale  = 0.70;

@interface ContainerViewController ()<UIGestureRecognizerDelegate>{

    UIView *_bgView;
    LeftMenuViewController *_leftMenuVC;
    TabbarViewController *_tabbarVC ;
    
}

@property (assign, nonatomic) menuState  menuState;
@property (assign, nonatomic) CGFloat leftPadding;         // 左间距
@property (assign, nonatomic) CGFloat kLeftPadding;        //起始左间距
@property (assign, nonatomic) CGFloat leftMenuCenterX; // 左菜单起始中点值
@property (assign, nonatomic) CGFloat currentLeftMenuCenterX;   // 当前左菜单中点值
@property (assign, nonatomic) CGFloat panPaddingX;        // 滑动可用范围X(0~70)


@end

@implementation ContainerViewController

+(ContainerViewController *)sharedContainerVC{

    static ContainerViewController *containerVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        containerVC=[[ContainerViewController alloc] init];
        
        
    });
    return containerVC;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.menuState=closeLeftMenu;
    self.leftPadding = 0;
    self.leftMenuCenterX = w * kSlideScale / 2.0;
    self.currentLeftMenuCenterX = self.view.center.x;
    self.kLeftPadding = w * slideViewScale;
    
    // 背景图片
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    bg.frame=CGRectMake(0, -10, w, h+10);
    bg.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    // 左菜单
     _leftMenuVC= [[LeftMenuViewController alloc] init];
    _leftMenuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kSlideScale, kSlideScale);
    _leftMenuVC.view.center = CGPointMake(self.leftMenuCenterX, _leftMenuVC.view.center.y);
    [self.view addSubview:_leftMenuVC.view];
    
    // 蒙层
    _bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _bgView.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:_cover];
    
    // tabBarController
    _tabbarVC = [[TabbarViewController alloc] init];
    //滑动手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_tabbarVC.view addGestureRecognizer:panGes];
    
    [self.view addSubview:_tabbarVC.view];
    
    //点击手势
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLeftMenuWithItem:)];
    tapGes.numberOfTapsRequired=1;
    tapGes.delegate=self;
    [_tabbarVC.view addGestureRecognizer:tapGes];
    
    
}


/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)panGes {
    // 当滑动水平X大于75时禁止滑动
    if (panGes.state == UIGestureRecognizerStateBegan) {
        self.panPaddingX = [panGes locationInView:self.view].x;
    }
    if (self.menuState == closeLeftMenu && self.panPaddingX >= 70) {
        return;
    }
    
    CGFloat x = [panGes translationInView:self.view].x;
    // 禁止在主界面的时候向左滑动
    if (self.menuState == closeLeftMenu && x < 0) {
        return;
    }
    
    CGFloat dis = self.leftPadding + x;
    // 当手势停止时执行操作
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (dis >= w * slideViewScale / 2.0) {
            [self openLeftMenu];
        } else {
            [self closeLeftMenuWithItem:_tabbarVC.tabVC.selectedIndex];
        }
        return;
    }
    
    CGFloat scale = (viewScaleForHeight - 1) * dis / self.kLeftPadding + 1;
    if (scale < viewScaleForHeight || scale > 1) {
        return;
    }
    _tabbarVC.view.center = CGPointMake(self.view.center.x + dis, h/2);
    _tabbarVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    

    _bgView.alpha = 1 - dis / self.kLeftPadding;
    
    CGFloat slideScale = dis * (1 - kSlideScale) / self.kLeftPadding + kSlideScale;
    CGFloat slideCenterX = dis * (self.currentLeftMenuCenterX - self.leftMenuCenterX) / self.kLeftPadding;
    _leftMenuVC.view.center = CGPointMake(self.leftMenuCenterX + slideCenterX, h/2);
    _leftMenuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, slideScale, slideScale);
}

/**
 *  展示侧边栏
 */
- (void)openLeftMenu {
    self.leftPadding = self.kLeftPadding;
    self.menuState = openLeftMenu;
    [self doSlide:viewScaleForHeight];
}

/**
 *  展示主界面
 */
- (void)closeLeftMenuWithItem :(NSInteger)item{
    _tabbarVC.tabVC.selectedIndex=item;
    self.leftPadding = 0;
    self.menuState = closeLeftMenu;
    [self doSlide:1];
}

/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)scale {
    
    _bgView.alpha = scale == 1 ? 1 : 0;
    CGFloat slideCenterX;
    CGFloat slideScale;
    if (scale == 1) {
        slideCenterX = self.leftMenuCenterX;
        slideScale = kSlideScale;
    } else {
        slideCenterX = self.currentLeftMenuCenterX;
        slideScale = 1;
    }

    POPSpringAnimation *transtionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    transtionAnimation.toValue = [NSValue valueWithCGPoint:(CGPointMake(self.view.center.x + self.leftPadding, self.view.center.y))];
    transtionAnimation.springBounciness = kSpringBounciness;
    [transtionAnimation setSpringSpeed:kSpringSpeed];
    [_tabbarVC.view pop_addAnimation:transtionAnimation forKey:@"TranstionAnimation"];

    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:(CGSizeMake(scale, scale))];
    scaleAnimation.springBounciness = kSpringBounciness;
    [scaleAnimation setSpringSpeed:kSpringSpeed];
    [_tabbarVC.view pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    
    POPSpringAnimation *transtionAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    transtionAnimation2.toValue = [NSValue valueWithCGPoint:(CGPointMake(slideCenterX, self.view.center.y))];
    transtionAnimation2.springBounciness = kSpringBounciness;
    [transtionAnimation2 setSpringSpeed:kSpringSpeed];
    [_leftMenuVC.view pop_addAnimation:transtionAnimation2 forKey:@"TranstionAnimation2"];
    
    POPSpringAnimation *scaleAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation2.toValue = [NSValue valueWithCGSize:(CGSizeMake(slideScale, slideScale))];
    scaleAnimation2.springBounciness = kSpringBounciness;
    [scaleAnimation2 setSpringSpeed:kSpringSpeed];
    [_leftMenuVC.view pop_addAnimation:scaleAnimation2 forKey:@"scaleAnimation2"];
    
    
    


    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]&&![NSStringFromClass([touch.view class]) isEqualToString:@"PaperButton"];
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
