#
# Be sure to run `pod lib lint CCLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'CCLib'
    s.version          = '0.1.21'
    s.summary          = '杜华金的个人私有库'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/duhuajin/CCLib'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'duhuajin' => '552923375@qq.com' }
    s.source           = { :git => 'https://github.com/duhuajin/CCLib.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    #  s.source_files = 'CCLib/Classes/**/*'
    
    s.subspec 'CCExts' do |ccexts|
        ccexts.source_files = 'CCLib/Classes/CCExts/*'
    end
    
    s.subspec 'CCJson' do |ccjson|
        ccjson.source_files = 'CCLib/Classes/CCJson/*'
    end
    
    s.subspec 'CCBase' do |ccbase|
        ccbase.source_files = 'CCLib/Classes/CCBase/*'
        ccbase.dependency 'CCLib/CCExts'
        ccbase.dependency 'CCLib/CCCollection'
        ccbase.dependency 'CCLib/CCJson'
        ccbase.dependency 'JSONModel'
        ccbase.dependency 'Masonry'
        ccbase.dependency 'MJRefresh'
    end
    s.subspec 'CCCollection' do |ccform|
        ccform.source_files = 'CCLib/Classes/CCCollection/*'
    end
    s.subspec 'CCDatePicker' do |ccdatepicker|
        ccdatepicker.source_files = 'CCLib/Classes/CCDatePicker/*'
        ccdatepicker.dependency 'Masonry'
        ccdatepicker.dependency 'CCLib/CCExts'
    end
    
    # s.resource_bundles = {
    #   'CCLib' => ['CCLib/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
