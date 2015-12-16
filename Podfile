platform :ios, '9.0'
use_frameworks!

pod 'Alamofire', '~> 3.0'
pod 'ReactiveCocoa', '4.0.4-alpha-4'
pod 'SwiftyJSON', '~> 2.3'

target 'SpringStateMachine-iOSTests' do
  pod 'Nimble', '~> 3.0.0'
  pod 'OHHTTPStubs', '~> 4.6'
  pod 'OHHTTPStubs/Swift', '~> 4.6'
end

post_install do |installer|
    installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
        configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
end