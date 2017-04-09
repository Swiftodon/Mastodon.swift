#
# Be sure to run `pod lib lint MastodonClient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MastodonClient'
  s.version          = '1.0.1'
  s.summary          = 'A Swift / RxSwift / Moya / Gloss based API client for Mastodon instances.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This client can be used to interact with Mastodon instances. It`s recommended to be used with RxSwift.
                       DESC

  s.homepage         = 'https://github.com/Swiftodon/Mastodon.swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => 'marcus@kida.io' }
  s.source           = { :git => 'https://github.com/kimar/Mastodon.swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kidmar'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.10'

  s.source_files = 'MastodonClient/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MastodonClient' => ['MastodonClient/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Moya/RxSwift', '~> 8.0.3'
  s.dependency 'Moya-Gloss/RxSwift', '~> 2.0.0'
end
