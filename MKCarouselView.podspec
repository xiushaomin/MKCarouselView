Pod::Spec.new do |s|
    s.name         = 'MKCarouselView'
    s.version      = '1.0.1'
    s.summary      = 'a carouselView like UITableView'
    s.homepage     = 'https://github.com/xiushaomin/MKCarouselView'
    s.license      = 'MIT'
    s.authors      = {'xiushaomin' => 'xiushaomin@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/xiushaomin/MKCarouselView.git', :tag => s.version}
    s.source_files = 'MKCarouselView/*.{h,m}'
    s.requires_arc = true
end