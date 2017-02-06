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



