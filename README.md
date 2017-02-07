### MKCarouselView

类似一些网站上的循环轮播广告

![](https://github.com/xiushaomin/MKCarouselView/blob/master/%E8%BD%AE%E6%92%AD%E5%9B%BE.gif)

- 文件两个类：`MKCarouselView和MKCarouselViewCell`，类似于`Tableview和Tableviewcell`

- 数据源代理：`MKCarouselViewDataSource`


`- (NSInteger)numberOfCellInCarouselView:(MKCarouselView *)carouselView;`

`- (MKCarouselViewCell *)carouselView:(MKCarouselView *)carouselView cellForIndex:(NSInteger)index;`


- 点击事件代理：`MKCarouselViewDelegate`


`- (void)carouselView:(MKCarouselView *)carouselView didClickTheCellAtIndex:(NSInteger)index;`


- 缓存使用方法：


`- (MKCarouselViewCell *)dequeueReusableCellWithIdentifier:(NSString *)indentifier;`

## MKCarouselView

[![CI Status](http://img.shields.io/travis/xiushaomin@gmail.com/MKCarouselView.svg?style=flat)](https://travis-ci.org/xiushaomin@gmail.com/MKCarouselView)
[![Version](https://img.shields.io/cocoapods/v/MKCarouselView.svg?style=flat)](http://cocoapods.org/pods/MKCarouselView)
[![License](https://img.shields.io/cocoapods/l/MKCarouselView.svg?style=flat)](http://cocoapods.org/pods/MKCarouselView)
[![Platform](https://img.shields.io/cocoapods/p/MKCarouselView.svg?style=flat)](http://cocoapods.org/pods/MKCarouselView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MKCarouselView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'MKCarouselView'
end
```

## Author

xiushaomin@gmail.com

## License

MKCarouselView is available under the MIT license. See the LICENSE file for more info.




