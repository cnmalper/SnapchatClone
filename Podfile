# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'SnapchatClone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'FirebaseAnalytics'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseCore'
pod 'FirebaseStorage'
pod 'SDWebImage'
pod 'ImageSlideshow', '~> 1.9.0'
pod "ImageSlideshow/SDWebImage"



  # Pods for SnapchatClone

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
        end
    end
end


end
