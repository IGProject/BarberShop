# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'BarberShop-V2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for BarberShop-V2
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Messaging'
pod 'FBSDKLoginKit'
pod 'FacebookCore'
pod 'FacebookLogin'
pod 'GoogleSignIn'
pod 'GoogleMaps'
pod 'GooglePlaces'

pod 'Alamofire', '~> 4.7'
pod 'ReachabilitySwift'
pod 'Kingfisher', '~> 4.0'

pod 'SideMenu'
pod 'JTAppleCalendar', '~> 7.0'
pod 'MXSegmentedPager'
pod 'PKHUD', '~> 5.0'
pod 'Material'
pod 'SSSpinnerButton'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
