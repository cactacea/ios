Pod::Spec.new do |s|
  s.name = 'Cactacea'
  s.summary = 'An iOS library to interface with Cactacea backend API'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.version = '18.11.0'
  s.source = { :git => 'https://github.com/cactacea/ios.git', :tag => '18.11.0' }
  s.authors = 'Takeshi Shimada'
  s.license = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage = 'https://github.com/cactacea/ios'
  s.summary = 'An iOS library to interface with Cactacea backend API'
  s.source_files = 'Cactacea/Classes/**/*.swift'
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'Alamofire', '~> 4.5.0'
end
