#
# Be sure to run `pod lib lint LRDesignSystem.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LRDesignSystem'
  s.version          = '0.5.1'
  s.summary          = '0.5.1 Fixes for GC'

  s.swift_version    = '5.0'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Wh	y did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Last update from january'

  s.homepage         = 'https://github.com/levin-riegner/LRDesignSystem'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oxean2014' => 'ileider@gmail.com' }
  s.source           = { :git => 'https://github.com/levin-riegner/LRDesignSystem.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'LRDesignSystem/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LRDesignSystem' => ['LRDesignSystem/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
