
platform :ios, 12.0
use_frameworks!

def shared_pods
  pod 'AlamofireObjectMapper'
  pod 'PieCrust'
  pod 'SnapKit'
end

target 'TechTest' do
  shared_pods
end

post_install do |installer|
  puts 'Patching SVGKit to compile with the ios 7 SDK'
  %x(patch Pods/path/to/file.m < localpods/patches/fix.patch)
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
