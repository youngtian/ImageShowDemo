//
//  ViewController.m
//  ImageShowDemo
//
//  Created by tianyaxu on 17/2/8.
//  Copyright © 2017年 tianyaxu. All rights reserved.
//

#import "ViewController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIScrollViewDelegate>
{
    NSArray *_imageArr;
    UIScrollView *_scrollView;
    int _index;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageArr = @[@"banner-01.png", @"banner-02.png", @"banner-03.png", @"banner-04.png"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, Width, 100)];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(Width * 2, 100);
    
    for (int i = 0; i < 2; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * Width, 0, Width, 100)];
        imgView.image = [UIImage imageNamed:_imageArr[i]];
        imgView.tag = i + 100;
        [scrollView addSubview:imgView];
    }
    _index = 1;
    _scrollView = scrollView;
    
    // 设置图片轮播的时间间隔
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)changeImage {
    // 设置scrollview的偏移量为（375，0）实现图片的轮播，打开动画效果
    [_scrollView setContentOffset:CGPointMake(Width, 0) animated:YES];
    // 设置监听scrollview滑动结束后的定时器
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark -ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // scrollview滑动结束之后，修改图片将第一个imgView的图片修改为当前显示的图片，第二个imgView的图片修改为下一张图片，然后就设置scrollview的偏移量为（0，0）不显示动画效果
    UIImageView *imgView0 = [_scrollView viewWithTag:100];
    UIImageView *imgView1 = [_scrollView viewWithTag:101];
    imgView0.image = [UIImage imageNamed:_imageArr[_index]];
    if (_index == 3) {
        _index = 0;
    } else {
        _index ++;
    }
    imgView1.image = [UIImage imageNamed:_imageArr[_index]];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
