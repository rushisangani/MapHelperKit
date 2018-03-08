Pod::Spec.new do |s|

s.name         = "MapHelperKit"
s.version      = "1.0"
s.summary      = "MapHelperKit provides an elegant way to show locations or directions in Google Maps or Apple Maps."
s.description  = <<-DESC
MapHelperKit provides easiest way to show different places in Maps. It also provides directions API to show in Apple Maps or Google Maps.
DESC
s.homepage     = "https://github.com/rushisangani/MapHelperKit"

s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "Rushi Sangani" => "rushisangani@gmail.com" }
s.source       = { :git => "https://github.com/rushisangani/MapHelperKit.git", :tag => s.version }

s.ios.deployment_target = '9.0'
s.source_files = "MapHelperKit/**/*.swift"
s.requires_arc = true
end

