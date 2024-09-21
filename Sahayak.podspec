Pod::Spec.new do |spec|
  spec.name           = "Sahayak"
  spec.version        = "1.2.0"
  spec.summary        = "My Helper in iOS App Development."
  spec.description    = "Comrade in developing iOS applications."
  spec.homepage       = "https://github.com/KamalDGRT/Sahayak"
  spec.license        = { :type => "MIT", :file => "LICENSE" }
  spec.author         = { "KamalDGRT" => "kamaldgrt@gmail.com" }
  spec.platform       = :ios, '17.0'
  spec.swift_version  = '5.0'
  spec.source         = { :git => "https://github.com/KamalDGRT/Sahayak.git", :tag => "#{spec.version}" }
  spec.source_files   = "Sahayak/**/*.{swift,h,m}"
end
