#!/bin/bash
# Build IPA for GoFast iOS App
# Run this on your Mac after transferring the project

set -e

SCHEME="GoFast"
BUNDLE_ID="com.gofast.driver"
APPLE_ID=""  # Enter your Apple ID email

echo "========================================"
echo "  GoFast iOS - IPA Builder"
echo "========================================"
echo ""

# Check if running on Mac
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ This script must run on macOS"
    exit 1
fi

# Check Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not installed. Install from App Store."
    exit 1
fi

echo "1. Opening Xcode project..."
open GoFast.xcodeproj

echo ""
echo "2. In Xcode:"
echo "   - Go to Signing & Capabilities"
echo "   - Enable 'Automatically manage signing'"
echo "   - Select your Apple ID team"
echo "   - Close Xcode when done"
echo ""
read -p "Press Enter to continue..."

echo "3. Building archive..."
xcodebuild -scheme "$SCHEME" \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "build/${SCHEME}.xcarchive" \
  clean archive || {
    echo "❌ Build failed. Check Xcode signing settings."
    exit 1
  }

echo ""
echo "✅ Archive created: build/${SCHEME}.xcarchive"
echo ""
echo "4. To export IPA, create ExportOptions.plist with your Team ID"
echo "   Then run:"
echo "   xcodebuild -exportArchive -archivePath build/${SCHEME}.xcarchive -exportPath build -exportOptionsPlist ExportOptions.plist"
echo ""
echo "5. Or use Sideloadly / eSign to sign and install directly"
echo ""
