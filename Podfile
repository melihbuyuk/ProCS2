# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def shared_pods
  pod 'Hero', '~> 1.5'
	pod 'Kingfisher', '~> 5'
  pod 'Moya'
  pod 'ObjectMapper', '~> 3.5'
  pod 'RealmSwift' #4.3.2
  pod 'SwiftyTimer', '~> 2.1'
end

target 'ProCS2' do
  shared_pods
end

target 'ProCS2Tests' do
  pod 'Moya'
  pod 'ObjectMapper', '~> 3.5'
  pod 'SwiftyTimer', '~> 2.1'
end

target 'ProCS2UITests' do
  shared_pods
end
