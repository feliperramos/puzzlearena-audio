Pod::Spec.new do |s|
  s.name         = "PuzzleArenaAudio"
  s.version      = "0.1.4"
  s.swift_version = "5.0"
  s.summary      = "Lightweight native sound module for React Native"
  s.description  = "A lightweight native audio module for React Native to handle background music and sound effects."
  s.homepage     = "https://github.com/feliperramos/puzzlearena-audio"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Felipe Ramos" => "feliperamos.tech" }
  s.source       = { :path => "." }
  s.platform     = :ios, "12.0"
  s.source_files = "ios/**/*.{h,m,swift}"
  s.dependency   "React-Core"
end
