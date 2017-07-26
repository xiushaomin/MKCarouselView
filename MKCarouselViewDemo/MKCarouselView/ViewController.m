//
//  ViewController.m
//  MKCarouselView
//
//  Created by gkd_xsm on 2017/2/6.
//  Copyright © 2017年 gkd_xsm. All rights reserved.
//
#import "MKCarouselViewCell.h"
#import "MKCarouselView.h"
#import "ViewController.h"

@interface ViewController ()<MKCarouselViewDelegate,MKCarouselViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSource = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [_dataSource addObject:image];
    }
    
    
    MKCarouselView *carouselView = [[MKCarouselView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 114)];
    carouselView.contentScrollScale = 0.75;
    carouselView.cellScale = 0.85;
    carouselView.delegate = self;
    carouselView.dataSource = self;
    [carouselView reloadData];
    [self.view addSubview:carouselView];
}

- (MKCarouselViewCell *)carouselView:(MKCarouselView *)carouselView cellForIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    MKCarouselViewCell *cell = [carouselView dequeueReusableCellWithIdentifier:@"MKCarouselViewCell"];
    if (!cell) {
        cell = [[MKCarouselViewCell alloc] initWithReusableIdentifier:@"MKCarouselViewCell"];
    }
    cell.imageView.image = _dataSource[index];
    return cell;
}

- (NSInteger)numberOfCellInCarouselView:(MKCarouselView *)carouselView {
    return _dataSource.count;
}

- (void)carouselView:(MKCarouselView *)carouselView didClickTheCellAtIndex:(NSInteger)index {
    NSLog(@"zzz");
}

@end
