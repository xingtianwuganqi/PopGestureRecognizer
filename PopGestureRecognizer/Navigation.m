//
//  Navigation.m
//  yiqidai
//
//  Created by TOBGO on 2017/3/14.
//  Copyright © 2017年 TOBGO. All rights reserved.
//

#import "Navigation.h"


@interface Navigation ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIPanGestureRecognizer *pan;
@property (nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgeGesOut;
@end

@implementation Navigation
+(void)initialize{
    //要用appearance初始化
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBarStyle:UIBarStyleBlack];
//    [bar setBackgroundColor:[UIColor whiteColor]];
//    [bar setBackgroundImage:[UIImage imageNamed:@"背景"] forBarMetrics:UIBarMetricsDefault];
    [bar setBarTintColor:[UIColor whiteColor]];//UIColorFromRGB(0xff386b)
    bar.translucent = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithRed:62/255.f green:62/255.f blue:62/255.f alpha:1];//[UIColor whiteColor]
    
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15 weight:0.3];// [UIFont fontWithName:@"HiraKakuProN-W6" size:15];

    [bar setTitleTextAttributes:dic];
    
    bar.barStyle = UIBarStyleDefault;// UIBarStyleBlack
    
    
    
    
//    //设置item属性
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSMutableDictionary *itemArrays = [NSMutableDictionary dictionary];
//    itemArrays[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    itemArrays[NSForegroundColorAttributeName] = UIColorFromRGB(0x323232);
//    [item setTitleTextAttributes:itemArrays forState:UIControlStateNormal];
//    
//    NSMutableDictionary *itemDisAttrys = [NSMutableDictionary dictionary];
//    itemDisAttrys[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [item setTitleTextAttributes:itemDisAttrys forState:UIControlStateDisabled];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return (self.topViewController !=[self.viewControllers firstObject]);
}
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    
    //解决与左滑手势冲突

    
    NSLog(@"%lu,%@",(unsigned long)self.childViewControllers.count,gestureRecognizer.view);

//如果哪个控制器不需要策划返回，就可以返回NO
//    if ([self.topViewController isKindOfClass:[CustomerServiceController class]]){
//        return NO;
//    }else if ([self.topViewController isKindOfClass:[ChatViewController class]]){
//        return NO;
//    }else if ([self.topViewController isKindOfClass:[WJLoginSelectViewController class]]){
//        return NO;
//    }

    
    return self.childViewControllers.count == 1 ? NO : YES;
}

                
            
- (void)viewDidLoad {
    
    [super viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");

    
    self.screenEdgeGesOut = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:target action:handler];
    self.screenEdgeGesOut.edges = UIRectEdgeLeft;
    self.screenEdgeGesOut.delegate = self;

    UIView *targetView = self.interactivePopGestureRecognizer.view;
    [targetView addGestureRecognizer:self.screenEdgeGesOut];

    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];

    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count !=0) {
        //设置返回按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //尺寸自适应
        button.frame = CGRectMake(0, 0, 12, 18);
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置文字颜色
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
//        //设置箭头图片
//        [button setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        //尺寸自适应
//        button.JY_size= CGSizeMake(kWidth(10), kHeight(17));
        
        //设置箭头图片
        [button setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //放在后面,可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}
//返回上一页
- (void)back
{
    
    [self popViewControllerAnimated:YES];
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
