//  Copyright © 2017年 gkd_xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKCarouselViewCell;
@protocol MKCarouselViewDelegate;
@protocol MKCarouselViewDataSource;

@interface MKCarouselView : UIView

/**
 定制的一些属性
 */
@property (nonatomic, assign) BOOL isAutoScroll;
@property (nonatomic, assign) CGFloat cellScale;
@property (nonatomic, assign) CGFloat cellAlpha;
@property (nonatomic, assign) CGFloat contentScrollScale;
@property (nonatomic, assign) NSTimeInterval autoScrollTime;

@property (nonatomic, weak) id<MKCarouselViewDelegate> delegate;
@property (nonatomic, weak) id<MKCarouselViewDataSource> dataSource;

/**
 入口方法
 */
- (void)reloadData;

- (void)stopTimer;

/**
 缓存
 @param indentifier 标识符
 @return 返回一个MKCarouselViewCell或者它的子类
 */
- (MKCarouselViewCell *)dequeueReusableCellWithIdentifier:(NSString *)indentifier;

@end



@protocol MKCarouselViewDelegate <NSObject>
@optional

/**
 点击协议
 @param carouselView MKCarouselView
 @param index 点击的index
 */
- (void)carouselView:(MKCarouselView *)carouselView didClickTheCellAtIndex:(NSInteger)index;

@end

@protocol MKCarouselViewDataSource <NSObject>
@required

/**
 数据源方法 参照TableView
 */
- (NSInteger)numberOfCellInCarouselView:(MKCarouselView *)carouselView;

- (MKCarouselViewCell *)carouselView:(MKCarouselView *)carouselView cellForIndex:(NSInteger)index;

@end
