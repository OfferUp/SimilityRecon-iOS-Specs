#
#  Be sure to run `pod spec lint SimilityRecon-iOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SimilityRecon-iOS"
  s.version      = "1.614"
  s.summary      = "Simility Recon SDK for iOS."
  s.description  = "Simility Recon SDK for iOS. Please visit our developer docs for detailed integration usage."
  s.homepage     = "https://simility.com/developer/#devicerecon"
  s.license      = { :type => "Vendored", :text => "Paid License" }
  s.author       = { "Simility Inc." => "contact@simility.com" }
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :http => "https://github.com/OfferUp/SimilityRecon-iOS-Specs/releases/download/v1.614/ios_recon_v1.614.zip" }
  s.source_files  = "ios_recon_v1.614"
  s.public_header_files = "ios_recon_v1.614/SimilityRecon.h"
  s.ios.vendored_library = "ios_recon_v1.614/libSimilityRecon.a"
  s.ios.frameworks = "CoreTelephony"
end
