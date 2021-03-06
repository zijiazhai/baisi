//
//  ZJEssenceViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZZJRecommandTableViewController.h"
#import "ZJEssenceViewController.h"
#import "ZJFiveTableViewController.h"
#import "ZJFiveTableViewController.h"

@interface ZJEssenceViewController () <UIScrollViewDelegate>

//标签栏底部的红色指示器  the red indicator on the buttom of view
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *GButton;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation ZJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏  set the navagation bar
    [self setUp];
    
    // 设置子控制器
    [self setChildController];
    
    //设置顶部的标签栏
    [self setTitleView];
    
    //底部的scrollview
    [self setScrollView];
    
}



- (void)setChildController
{
    
    ZJFiveTableViewController *word = [[ZJFiveTableViewController alloc]init];
    word.title = @"段子";
    word.type = ZJTopicTypeWord;
    [self addChildViewController:word];
    
    ZJFiveTableViewController *all = [[ZJFiveTableViewController alloc]init];
    all.title = @"全部";
    all.type = ZJTopicTypeAll;
    [self addChildViewController:all];
    
    ZJFiveTableViewController *voice = [[ZJFiveTableViewController alloc]init];
    voice.title = @"声音";
    voice.type = ZJTopicTypeVoice;
    [self addChildViewController:voice];
    
    ZJFiveTableViewController *media = [[ZJFiveTableViewController alloc]init];
    media.title = @"视频";
    media.type = ZJTopicTypeVideo;
    [self addChildViewController:media];
    
    ZJFiveTableViewController *image = [[ZJFiveTableViewController alloc]init];
    image.title = @"图片";
    image.type = ZJTopicTypePicture;
    [self addChildViewController:image];
    
}


- (void)setScrollView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    CGFloat width = contentView.width * self.childViewControllers.count;

    
    contentView.contentSize = CGSizeMake(width, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}

- (void)setUp
{
    self.title = @"main page";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" taget:self action:@selector(button1Click)];
    
    self.view.backgroundColor = ZJBGColor;
}

- (void)setTitleView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:100/100.0 alpha:0.5];
    titleView.width = self.view.width;
    titleView.height = 36;
    titleView.y = 60;
    [self.view addSubview:titleView];
    self.titleView = titleView;

    
    
    // 底部的红色指示器 the red indicator on the buttom
    UIView *indicator = [[UIView alloc]init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.tag = -1;
    indicator.y = titleView.height - indicator.height;
    
  
    self.indicatorView = indicator;
    
    
    // 内部的子标签

    NSInteger num = self.childViewControllers.count;
    
    for (NSInteger i = 0; i < num; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.height = titleView.height;
        button.width = titleView.width/num;
        button.x = i *button.width;
        button.tag = i;
        UIViewController *vc = [[UIViewController alloc]init];
        vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
        
        // 默认选中点击第一个按钮  the first button is selected default
        
        if(i == 0)
        {
            button.selected = YES;
            self.GButton = button;
            
            //让按钮内部的label根据文字内容来计算， 如果没有这一句话， 第一个默认点击的按钮下边的指示器不会出现。
            
            [button.titleLabel sizeToFit];
            indicator.width = button.titleLabel.width;
            indicator.centerX = button.centerX;
        }
    }
    
     [titleView addSubview:indicator];
}

- (void)titleClick: (UIButton *)button
{
    self.GButton.selected = NO;
    button.selected = YES;
    self.GButton = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}



- (void)button1Click
{
    ZZJRecommandTableViewController *vc = [[ZZJRecommandTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // get the index in scrollView
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
//    UIButton *bu = [[UIButton alloc]init];
//    bu = self.titleView.subviews[index];
//    [self titleClick:bu];

    
    // create subController and get the tableViewController
    UIViewController *vc = [[UIViewController alloc]init];
    vc = self.childViewControllers[index];
    
    //size and point for tableViewController
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;    // the default y for controller is 20
    vc.view.height = scrollView.height;
    
    
    
    // add all the uitable into scrollView
    [scrollView addSubview:vc.view];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleView.subviews[index]];
}


@end
