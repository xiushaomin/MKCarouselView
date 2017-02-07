//  Copyright © 2017年 gkd_xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKCarouselViewCell : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy ,readonly) NSString *indentifer;

- (instancetype)initWithReusableIdentifier:(NSString *)indentifer;

@end
