Pod::Spec.new do |s|
  s.name             = 'MastodonClient'
  s.version          = '1.0.1'
  s.summary          = 'A Swift / RxSwift / Moya / Gloss based API client for Mastodon instances.'

  s.description      = <<-DESC
This client can be used to interact with Mastodon instances. It`s recommended to be used with RxSwift.
                       DESC

  s.homepage         = 'https://github.com/kimar/Mastodon.swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => 'marcus@kida.io' }
  s.source           = { :git => 'https://github.com/kimar/Mastodon.swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'Moya/RxSwift', '~> 8.0.3'
  s.dependency 'Moya-Gloss/RxSwift', '~> 2.0.0'
end
