Pod::Spec.new do |s|
  s.name = 'Cactacea'
  s.version = '19.9.4'
  s.summary = 'Cactacea iOS SDK'
  s.description = 'An iOS library to interface with Cactacea backend API'
  s.ios.deployment_target = '9.0'
  s.source = { :git => 'https://github.com/cactacea/ios.git', :tag => s.version.to_s }
  s.author = { 'Takeshi Shimada' => 'expensivegasprices@gmail.com' }
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'https://github.com/cactacea/ios'
  s.source_files = 'Cactacea/Classes/**/*.swift'
  s.dependency 'RxSwift', '~> 4.4'
  s.dependency 'Alamofire', '~> 4.7.3'
end
