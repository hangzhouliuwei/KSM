
use_frameworks!
platform:ios,'12.0'
inhibit_all_warnings!
target 'XTApp' do
pod 'YTKNetwork', '~> 3.0.6'
pod 'YYModel', '~> 1.0.4'
pod 'SDWebImage'
pod 'Masonry', '~> 1.1.0'
pod 'MBProgressHUD', '~> 1.2.0'
pod 'MJRefresh', '~> 3.1.15.3'
# RC
pod 'ReactiveObjC', '~> 3.1.0'
# 富文本
pod 'YYText'
# 弹框
pod 'YFPopView','~> 3.0.1'
# 轮播
pod 'TYCyclePagerView', '~> 1.2.0'
pod 'IQKeyboardManager', '6.5.10’
# 验证码
pod 'CRBoxInputView', '~> 1.2.2'
# 设备号存储
pod 'SAMKeychain', '~> 1.5.3'
#  pod 'Bugly'#bug统计工具
pod 'AAINetwork', :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAINetwork/AAINetwork-V1.0.0.tar.bz2', type: :tbz
pod 'AAILiveness', :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/2.0.6/iOS-Liveness-SDK-V2.0.6.tar.bz2', type: :tbz
  
  post_install do |installer|
     bitcode_strip_path = `xcrun --find bitcode_strip`.chop!
     def strip_bitcode_from_framework(bitcode_strip_path, framework_relative_path)
       framework_path = File.join(Dir.pwd, framework_relative_path)
       command = "#{bitcode_strip_path} #{framework_path} -r -o #{framework_path}"
       puts "Stripping bitcode: #{command}"
       system(command)
     end
     framework_paths = [
       "/Pods/AAINetwork/AAINetwork.xcframework/ios-arm64_armv7/AAINetwork.framework/AAINetwork",
       "/Pods/AAILiveness/AAILivenessSDK/AAILivenessSDK.xcframework/ios-arm64_armv7/AAILivenessSDK.framework/AAILivenessSDK",
     ]
     framework_paths.each do |framework_relative_path|
       strip_bitcode_from_framework(bitcode_strip_path, framework_relative_path)
     end
   end
end
