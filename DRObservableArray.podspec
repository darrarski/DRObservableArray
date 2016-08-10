Pod::Spec.new do |s|
  s.name                  = 'DRObservableArray'
  s.version               = '1.0.4'
  s.summary               = 'Observable array and observable mutable array protocol with generic implementations'
  s.homepage              = 'https://github.com/darrarski/DRObservableArray'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.social_media_url      = 'https://twitter.com/darrarski'
  s.source                = { :git => 'https://github.com/darrarski/DRObservableArray.git', :tag => 'v1.0.4' }
  
  s.requires_arc          = true
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = '10.11'
  s.source_files          = 'DRObservableArray/Common/*.{h,m}'
  s.ios.source_files      = 'DRObservableArray/iOS/*.{h,m}'
  s.osx.source_files      = 'DRObservableArray/macOS/*.{h,m}'
end
