//  Copyright © 2017年 gkd_xsm. All rights reserved.
//

#import "MKCarouselViewCell.h"

@interface MKCarouselViewCell()

@property (nonatomic, copy ,readwrite) NSString *indentifer;

@end

@implementation MKCarouselViewCell

- (instancetype)initWithReusableIdentifier:(NSString *)indentifer {
    if (self = [super init]) {
        self.indentifer = indentifer;
        //离屏渲染
        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    _imageView.frame = self.bounds;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
