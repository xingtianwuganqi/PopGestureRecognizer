//
//  SecondViewController.m
//  PopGestureRecognizer
//
//  Created by 景军 on 2017/12/24.
//  Copyright © 2017年 com.technology. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第二页";
    self.view.backgroundColor = [UIColor greenColor];
    [self setScrollView];
}
- (void)setScrollView{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, self.view.frame.size.height);
    scroll.pagingEnabled = YES;
    NSArray *arr = @[[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor]];
    [self.view addSubview:scroll];
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
        view.backgroundColor = arr[i];
        [scroll addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, self.view.frame.size.width / 3, [UIScreen mainScreen].bounds.size.width - 60, 120)];
        label.text = @"第二页view有一个scrollview,在scrollview边缘会触发右划返回手势，在其他地方滑动触发scollview滚动手势，相比全屏侧滑返回手势，减少了其他手势与右划手势的冲突，相对系统自带的侧滑手势更加简单";
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self.view addSubview:label];
        
        [view addSubview:label];
        
    }
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

