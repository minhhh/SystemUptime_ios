FRAMEWORK=SystemUptime

BUILD=build
FRAMEWORK_PATH=lib$FRAMEWORK.a

# iOS
rm -Rf $FRAMEWORK/$BUILD

xcodebuild archive -project $FRAMEWORK/$FRAMEWORK.xcodeproj -scheme $FRAMEWORK -sdk iphoneos SYMROOT=$BUILD
xcodebuild build -project $FRAMEWORK/$FRAMEWORK.xcodeproj -target $FRAMEWORK -sdk iphonesimulator SYMROOT=$BUILD

cp -RL $FRAMEWORK/$BUILD/Release-iphoneos $BUILD

lipo -create $FRAMEWORK/$BUILD/Release-iphoneos/$FRAMEWORK_PATH $FRAMEWORK/$BUILD/Release-iphonesimulator/$FRAMEWORK_PATH -output $BUILD/$FRAMEWORK_PATH
