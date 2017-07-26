//  Copyright © 2017年 gkd_xsm. All rights reserved.
//

#import "MKCarouselView.h"
#import "MKCarouselViewCell.h"

CGFloat const kTagDifferenceNums = 9999;

@interface MKCarouselView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger allCellCounts;
@property (nonatomic, assign) NSInteger scrollToIndex;
@property (nonatomic, assign) NSUInteger numberOfCells;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *placeholderArray;
@property (nonatomic, strong) NSMutableDictionary *reuseCacha;

@end

@implementation MKCarouselView

#pragma mark - Initializer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_configDefaultValues];
    }
    return self;
}

- (void)p_configDefaultValues {
    self.cellScale = 1.f;
    self.autoScrollTime = 1.f;
    self.contentScrollScale = 1.f;
    self.cellAlpha = 0.5;
    self.isAutoScroll = YES;
    [self addSubview:self.scrollView];
    
}

#pragma mark - PublicMethods

- (void)reloadData {
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfCellInCarouselView:)]) {
        _numberOfCells = [_dataSource numberOfCellInCarouselView:self];
        _allCellCounts = _numberOfCells == 1 ? 1 : _numberOfCells * 3;
    }
    
    if (_numberOfCells == 0) {
        return;
    }
    
    [self.reuseCacha removeAllObjects];
    [self.placeholderArray removeAllObjects];
    for (int i = 0; i < _allCellCounts; i++) {
        [self.placeholderArray addObject:[NSNull null]];
    }
    
    self.scrollView.bounds = (CGRect){0, 0, self.bounds.size.width * _contentScrollScale, self.bounds.size.height * _contentScrollScale};
    self.scrollView.contentSize = (CGSize){self.bounds.size.width * _contentScrollScale * _allCellCounts, 0};
    self.scrollView.center = (CGPoint){CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)};
    
    _scrollToIndex = _numberOfCells;
    
    if (_numberOfCells > 1) {
        [self.scrollView setContentOffset:(CGPoint){_scrollView.bounds.size.width * _scrollToIndex, 0} animated:NO];
    }
    
    if (_numberOfCells == 1) {
        MKCarouselViewCell *cell = [_dataSource carouselView:self cellForIndex:_numberOfCells % _numberOfCells];
        cell.frame = (CGRect){0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height};
        if (!cell.superview) {
            [self.scrollView addSubview:cell];
        }
    }
    
  //  [self p_startTimer];
    
}

- (MKCarouselViewCell *)dequeueReusableCellWithIdentifier:(NSString *)indentifier {
    NSMutableArray *reuseQueue = [self.reuseCacha objectForKey:indentifier];
    MKCarouselViewCell *cell = nil;
    if (reuseQueue.count > 0) {
        cell = reuseQueue.firstObject;
        [reuseQueue removeObject:cell];
    }
    return cell;
}

- (void)stopTimer {
    [self p_stopTimer];
}

#pragma mark - PrivateMthods

- (void)p_startTimer {
    if (_numberOfCells > 1 && _isAutoScroll) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTime target:self selector:@selector(p_autoScrollCells) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)p_autoScrollCells {
    
    if (_scrollToIndex == _numberOfCells * 2) {
        [self.scrollView setContentOffset:(CGPoint){self.scrollView.bounds.size.width * _numberOfCells, 0} animated:NO];
        _scrollToIndex = _numberOfCells;
    }
    _scrollToIndex++;
    [self.scrollView setContentOffset:(CGPoint){self.scrollView.bounds.size.width * _scrollToIndex, 0} animated:YES];

}


- (void)p_stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView && _numberOfCells > 1) {
        
        if (scrollView.contentOffset.x / scrollView.bounds.size.width >= _numberOfCells * 2) {
            [scrollView setContentOffset:(CGPoint){scrollView.bounds.size.width * _numberOfCells, 0} animated:NO];
            self.scrollToIndex = _numberOfCells;
        }
        
        if (scrollView.contentOffset.x / scrollView.bounds.size.width <= _numberOfCells - 1) {
            [scrollView setContentOffset:(CGPoint){scrollView.bounds.size.width * (_numberOfCells * 2 - 1), 0} animated:NO];
            self.scrollToIndex = 2 * _numberOfCells;
        }
        
        [self p_findTheVisibleIndexWithScrollView:scrollView];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == self.scrollView && _numberOfCells > 1) {
        CGFloat offset_index = floor(scrollView.contentOffset.x / scrollView.bounds.size.width);
        if (_scrollToIndex == offset_index) {
            _scrollToIndex = offset_index + 1;
        } else {
            _scrollToIndex = offset_index;
        }
        
      //  [self p_startTimer];
    }

}

#pragma mark - Core Methods

- (void)p_findTheVisibleIndexWithScrollView:(UIScrollView *)scrollView {
    
    CGFloat startOffset_x = scrollView.contentOffset.x;
    CGFloat endOffset_x = scrollView.contentOffset.x + scrollView.bounds.size.width;
    
    NSInteger startVisibleIndex = 0;
    
    for (NSInteger i = 0; i < _allCellCounts; i++) {
        if (scrollView.bounds.size.width * (i + 1) >= startOffset_x) {
            startVisibleIndex = i;
            break;
        }
    }
    
    NSInteger endVisibleIndex = startVisibleIndex;
    for (NSInteger i = startVisibleIndex; i < _allCellCounts; i++) {
        if (scrollView.bounds.size.width * (i + 1) >= endOffset_x) {
            endVisibleIndex = i + 1;
            break;
        }
    }
    
    for (NSInteger i = 0; i < startVisibleIndex - 1; i++) {
        MKCarouselViewCell *cell = [self.placeholderArray objectAtIndex:i];
        if ([cell isKindOfClass:[MKCarouselViewCell class]]) {
            [self.placeholderArray replaceObjectAtIndex:i withObject:[NSNull null]];
            [self p_cachaCell:cell];
        }
    }
    
    for (NSInteger i = endVisibleIndex + 1; i < _allCellCounts; i++) {
        MKCarouselViewCell *cell = [self.placeholderArray objectAtIndex:i];
        if ([cell isKindOfClass:[MKCarouselViewCell class]]) {
            [self.placeholderArray replaceObjectAtIndex:i withObject:[NSNull null]];
            [self p_cachaCell:cell];
        }
    }
    
    startVisibleIndex = MAX(startVisibleIndex - 1, 0);
    endVisibleIndex = MIN(endVisibleIndex + 1, self.placeholderArray.count - 1);
    
    for (NSInteger i = startVisibleIndex; i <= endVisibleIndex; i++) {
        MKCarouselViewCell *cell =  [self.placeholderArray objectAtIndex:i];
        if ([cell isKindOfClass:[NSNull class]]) {
            if (_dataSource && [_dataSource respondsToSelector:@selector(carouselView:cellForIndex:)]) {
                MKCarouselViewCell *cell = [_dataSource carouselView:self cellForIndex:i % _numberOfCells];
                [self.placeholderArray replaceObjectAtIndex:i withObject:cell];
                if (!cell.superview) {
                    cell.frame = (CGRect){scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height};
                    [self.scrollView addSubview:cell];
                }
            }
        }
    }
    
    for (NSInteger i = startVisibleIndex; i <= endVisibleIndex; i++) {
        MKCarouselViewCell *cell =  [self.placeholderArray objectAtIndex:i];
        
        CGFloat cell_x = cell.frame.origin.x;
        CGFloat difference_x = fabs(cell_x - startOffset_x);
        
        cell.tag = i % _numberOfCells + kTagDifferenceNums;
        
        if (cell.gestureRecognizers.count == 0) {
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_clickedTheCell:)];
            [cell addGestureRecognizer:gesture];
        }
        
        CGRect oldFrame = (CGRect){scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height};
        
        if (difference_x < scrollView.bounds.size.width) {
            CGFloat scale = (scrollView.bounds.size.width * (1 - _cellScale)) / 2.f * (difference_x / scrollView.bounds.size.width);
            cell.frame = UIEdgeInsetsInsetRect(oldFrame, UIEdgeInsetsMake(scale, scale, scale, scale));
        } else {
            CGFloat scale = scrollView.bounds.size.width * (1 - _cellScale) / 2.f;
            cell.frame = UIEdgeInsetsInsetRect(oldFrame, UIEdgeInsetsMake(scale, scale, scale, scale));
        }
    }
}

#pragma mark - GestureAction

- (void)p_clickedTheCell:(UITapGestureRecognizer *)gesture {
    if (_delegate && [_delegate respondsToSelector:@selector(carouselView:didClickTheCellAtIndex:)]) {
        [_delegate carouselView:self didClickTheCellAtIndex:(gesture.view.tag - kTagDifferenceNums)];
    }
}

- (void)p_cachaCell:(MKCarouselViewCell *)cell {
    NSMutableArray *reuseQueue = [self.reuseCacha objectForKey:cell.indentifer];
    if (!reuseQueue) {
        reuseQueue = [NSMutableArray array];
    }
    [reuseQueue addObject:cell];
    [self.reuseCacha setObject:reuseQueue forKey:cell.indentifer];
    [cell removeFromSuperview];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSMutableArray *)placeholderArray {
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray array];
    }
    return _placeholderArray;
}

- (NSMutableDictionary *)reuseCacha {
    if (!_reuseCacha) {
        _reuseCacha = [[NSMutableDictionary alloc] init];
    }
    return _reuseCacha;
}

@end
