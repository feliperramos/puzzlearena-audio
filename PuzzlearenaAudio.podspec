Pod::Spec.new do |s|
  s.name         = "PuzzlearenaAudio"
  s.version      = "0.1.0"
  s.summary      = "Lightweight native sound module for React Native"
  s.description  = "A lightweight native audio module for React Native to handle background music and sound effects."
  s.homepage     = "https://github.com/feliperramos/puzzlearena-audio"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Felipe Ramos" => "feliperamos.tech" }
  s.source       = { :path => "." }
  s.platform     = :ios, "11.0"
  s.source_files = "ios/**/*.{h,m,swift}"
  s.dependency   "React-Core"
end
