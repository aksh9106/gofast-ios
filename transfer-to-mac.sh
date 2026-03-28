#!/bin/bash
# Transfer iOS project to Mac via network or prepare for USB transfer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="gofast-ios"

echo "========================================"
echo "  GoFast iOS - Transfer to Mac"
echo "========================================"
echo ""

# Create a zip file for easy transfer
cd "$SCRIPT_DIR"
echo "Creating zip archive..."
zip -r "${PROJECT_NAME}.zip" "$PROJECT_NAME" -x "*.DS_Store" "*.git*" 2>/dev/null || tar -czf "${PROJECT_NAME}.tar.gz" "$PROJECT_NAME"

echo ""
echo "✓ Project ready for transfer!"
echo ""
echo "Transfer options:"
echo ""
echo "1. USB Drive:"
echo "   Copy these files to USB, then to Mac:"
echo "   - ${PROJECT_NAME}/"
echo "   - ${PROJECT_NAME}.zip (if created)"
echo ""
echo "2. Network (if Mac is on same network):"
echo "   scp -r ${PROJECT_NAME} user@mac-address:/Users/yourname/"
echo ""
echo "3. Cloud Storage:"
echo "   Upload ${PROJECT_NAME}.zip to Google Drive, Dropbox, etc."
echo ""
echo "4. AirDrop (from Linux alternative):"
echo "   Use KDE Connect or similar"
echo ""

# Show project size
echo "Project size:"
du -sh "$PROJECT_NAME" 2>/dev/null || ls -lh "$PROJECT_NAME"

echo ""
echo "On your Mac:"
echo "1. Open ${PROJECT_NAME}/GoFast.xcodeproj in Xcode"
echo "2. Select your iPhone from device list"
echo "3. Press Cmd+R to build and run"
echo ""
