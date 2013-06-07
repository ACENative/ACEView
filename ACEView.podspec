Pod::Spec.new do |s|
  s.name         = "ACEView"
  s.version      = "0.1"
  s.summary      = "Use the ACE editor in your Cocoa applications."
  s.description  = <<-DESC
                    The ACEView framework aims to allow you to use the ACE source code editor in your Cocoa applications, as if it were a native control.
                   DESC
  s.homepage     = "https://github.com/AquarHEAD/ACEView"
  s.license      = {
    :type => 'BSD',
    :file => 'LICENSE'
  }
  s.authors      = { "Michael Robinson" => "mike@pagesofinterest.net", "AquarHEAD Lou" => "aquarhead@gmail.com" }
  s.source       = {
    :git => 'https://github.com/AquarHEAD/ACEView.git',
    :submodules => true
  }
  s.platform     = :osx
  s.frameworks   = ['WebKit']
  s.resource     = ['ACEView/Dependencies/ace/src-min/*.js', 'ACEView/HTML/index.html']
  s.source_files = 'ACEView/Source/**/*.{h,m}'
end
