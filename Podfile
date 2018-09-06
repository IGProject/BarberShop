# Uncomment the next line to define a global platform for your project
 platform :ios, '9.3'

target 'BarberShop-V2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for BarberShop-V2
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'FBSDKLoginKit'
pod 'FacebookLogin'
pod 'GoogleSignIn'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod 'RxSwift',    '~> 4.0'
pod 'RxCocoa',    '~> 4.0'
pod 'Alamofire', '~> 4.7'
pod 'Kingfisher', '~> 4.0'
pod 'SideMenu'
pod 'MXSegmentedPager'
pod 'FSCalendar'
pod 'Material'
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end