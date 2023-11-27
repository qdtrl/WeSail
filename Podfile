# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'WeSail' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Firebase', '>= 10.18.0'
  pod 'FirebaseAuth', '>= 10.18.0'
  pod 'FirebaseAnalytics', '>= 10.18.0'
  pod 'FirebaseDatabase', '>= 10.18.0'
  pod 'FirebaseFirestore', '>= 10.18.0'
  pod 'FirebaseStorage', '>= 10.18.0'
  pod 'GoogleSignIn', '>= 5.0.2'

  target 'WeSailTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeSailUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end