Pod::Spec.new do |s|
      s.name         = 'HHCProgressHUD'
      s.version      = '0.3'
      s.summary      = '用于需要一定时间等待的提示,或时成功失败的提示'
      s.homepage     = ''
      s.authors      = { 'wangyanrui' => 'tieunit@gmail.com'}
      s.license      = { :type => "MIT", :file => "LICENSE" }
      s.platform     = :ios, '9.0'
      s.ios.deployment_target = '9.0'
      s.source       = { :git => '', :tag => '0.3'}
      s.source_files = 'ProgressHUD/lib/*.{swift}','ProgressHUD/lib/Media.xcassets/*.png'
      s.requires_arc = true
    end