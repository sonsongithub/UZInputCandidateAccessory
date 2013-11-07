xcodebuild -sdk iphoneos -arch armv7 -arch armv7s clean build
xcodebuild -sdk iphonesimulator -arch i386 clean build

xcrun lipo -create build/Release-iphonesimulator/libUZInputCandidateAccessory.a build/Release-iphoneos/libUZInputCandidateAccessory.a -output build/libUZInputCandidateAccessory.a
cp ./UZInputCandidateAccessory/UZInputCandidateAccessory.h ./build/
