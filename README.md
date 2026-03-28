# GoFast Delivery Driver - iOS App

Native iOS WebView wrapper for the GoFast Delivery Driver web application.

## Project Structure

```
gofast-ios/
├── GoFast.xcodeproj/          # Xcode project
├── GoFast/
│   ├── AppDelegate.swift      # App entry point
│   ├── WebViewController.swift # WebView controller
│   ├── Info.plist             # App configuration
│   ├── Assets.xcassets/       # App icons and colors
│   └── Base.lproj/
│       ├── LaunchScreen.storyboard
│       └── Main.storyboard
└── README.md
```

## Requirements

- **macOS** with **Xcode 15.0+** installed
- **Apple Developer Account** (free or paid)
- **iPhone** with iOS 15.0 or later

## Installation Steps

### Step 1: Transfer Files to Mac

Copy the entire `gofast-ios` folder to your Mac:

```bash
# Option A: Using USB drive
# Copy gofast-ios folder to USB, then to Mac

# Option B: Using network
scp -r gofast-ios user@mac:/Users/yourname/

# Option C: Using AirDrop or cloud storage
```

### Step 2: Open in Xcode

1. On your Mac, navigate to the `gofast-ios` folder
2. Double-click `GoFast.xcodeproj` to open in Xcode

### Step 3: Configure Signing

1. In Xcode, select the **GoFast** project in the left sidebar
2. Go to the **Signing & Capabilities** tab
3. Under **Signing**, choose:
   - **Team**: Select your Apple ID (add account if needed via Xcode → Settings → Accounts)
   - **Bundle Identifier**: `com.gofast.driver` (should be auto-filled)

### Step 4: Build and Run

1. Connect your iPhone to Mac via USB
2. In Xcode toolbar, select your iPhone from the device list
3. Click the **Run** button (▶️) or press `Cmd + R`

Xcode will:
- Build the app
- Install it on your iPhone
- Launch it automatically

### Step 5: Trust the Developer (First Time Only)

On your iPhone:
1. Go to **Settings → General → VPN & Device Management**
2. Under **Developer App**, tap your Apple ID email
3. Tap **Trust**

## App Features

- ✅ Full web app in native wrapper
- ✅ Camera access for QR scanning
- ✅ Geolocation support
- ✅ Photo upload for delivery proof
- ✅ Pull-to-refresh
- ✅ Progress indicator
- ✅ Green theme (#28a745)
- ✅ Portrait mode locked

## Troubleshooting

### "No provisioning profiles found"
1. Go to Xcode → Settings → Accounts
2. Select your Apple ID
3. Click "Manage Certificates"
4. Click "+" → "Apple Development"

### "Failed to install app"
1. Make sure iPhone is unlocked
2. Check USB cable connection
3. Try restarting Xcode

### Camera/Location not working
Make sure to grant permissions when prompted on first launch.

## Build for Distribution (Optional)

For App Store or TestFlight:

1. Select "Any iOS Device (arm64)" as build target
2. Product → Archive
3. In Organizer, click "Distribute App"

## Package Name
`com.gofast.driver`

## Version
1.0

## Minimum iOS Version
15.0
