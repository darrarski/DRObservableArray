Pod::Spec.new do |s|
  s.name         = 'DRObservableArray'
  s.version      = '1.0.0'
  s.summary      = 'Observable array and observable mutable array protocol with generic implementations'
  s.homepage     = 'https://github.com/darrarski/DRObservableArray'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.source       = { :git => 'https://github.com/darrarski/DRObservableArray.git', :tag => 'v1.0.0' }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source_files = 'DRObservableArray'
  s.requires_arc = true
end
