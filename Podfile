# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'tagwaiter' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireObjectMapper', '~> 4.0'
  pod 'SDWebImage', '~>3.8'
  pod 'RealmSwift'
  pod 'ObjectMapper+Realm'

  # Pods for tagwaiter

  target 'tagwaiterTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'tagwaiterUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
