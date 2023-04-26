#
# Be sure to run `pod lib lint YWMoyaPlugins.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YWMoyaPlugins'
  s.version          = '0.1.0'
  s.summary          = 'Some of the Moya plugins used in development.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Some of the development of the use of Moya plugin, easy to print some request response information, or easy to deal with the Internet rhetoric and response information reminders.

  s.homepage         = 'https://github.com/weiyou2012/YWMoyaPlugins'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'weiyou' => 'youv686@gmail.com' }
  s.source           = { :git => 'https://github.com/weiyou2012/YWMoyaPlugins.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'YWMoyaPlugins/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YWMoyaPlugins' => ['YWMoyaPlugins/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency "Moya", '~> 14.0.0'
end
