Pod::Spec.new do |spec|

  spec.name         = "ZHPayKit"
  spec.version      = "1.0.0"
  spec.author       = { "YONG ZHAN" => "senyou2012@163.com" }
  spec.summary      = "移动支付，集成支付宝支付，微信支付"

  spec.homepage     = "https://github.com/driverZhan/ZHPayKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.source       = { :git => "https://github.com/driverZhan/ZHPayKit.git", :tag => spec.version.to_s }

  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = '9.0'
  spec.requires_arc = true
  spec.swift_version = '4.2'

  spec.source_files  = "ZHPayKit/Classes/*"
  spec.dependency 'AlipaySDK-iOS,WechatOpenSDK'

end
