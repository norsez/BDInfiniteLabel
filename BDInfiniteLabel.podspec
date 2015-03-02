#
# Be sure to run `pod lib lint BDInfiniteLabel.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BDInfiniteLabel"
  s.version          = "0.3.0"
  s.summary          = "One-line label control that allows user to easily scroll long NSAttributedString."
  s.description      = <<-DESC
                       One-line label control that allows user to easily scroll long NSAttributedString.

                       * Great for fitting long text in a tight one-line space
                       * User can scroll, well, page through long text. See demo.
                       * No support for multiple-line text
                       DESC
  s.homepage         = "https://github.com/norsez/BDInfiniteLabel"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Norsez Orankijanan" => "norsez@gmail.com" }
  s.source           = { :git => "https://github.com/norsez/BDInfiniteLabel.git", :tag => s.version.to_s }
#s.social_media_url = 'https://twitter.com/norsez

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BDInfiniteLabel' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'QuartzCore'
  # s.dependency 'AFNetworking', '~> 2.3'
end
