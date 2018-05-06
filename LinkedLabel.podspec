Pod::Spec.new do |s|
  s.name         = "LinkedLabel"
  s.version      = "0.1.0"
  s.summary      = "LinkedLabel, written in Swift."
  s.description  = <<-DESC
                    LinkedLabel, written in Swift.
                   DESC
  s.homepage     = "https://github.com/WXGBridgeQ/LinkedLabel"
  s.license      = "MIT"
  s.author       = { "Leo Zhou" => "wxg.bridgeq@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/WXGBridgeQ/LinkedLabel.git", :tag => "#{s.version}" }
  s.source_files  = "LinkedLabel/*.{swift}"
end
