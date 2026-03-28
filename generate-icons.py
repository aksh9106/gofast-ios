#!/usr/bin/env python3
from PIL import Image
import os

# Source logo
source = "/home/mahnish/gofastdelivery/gofast.jpeg"
icon_dir = "/home/mahnish/gofast-ios/GoFast/Assets.xcassets/AppIcon.appiconset"
splash_dir = "/home/mahnish/gofast-ios/GoFast/Assets.xcassets/SplashLogo.imageset"

# Open and convert to PNG
img = Image.open(source)
if img.mode != 'RGBA':
    img = img.convert('RGBA')

# iOS icon sizes
sizes = {
    'app-icon-180.png': (180, 180),   # iPhone 60pt @3x
    'app-icon-120.png': (120, 120),   # iPhone 60pt @2x
    'app-icon-76.png': (76, 76),      # iPad 76pt @1x
    'app-icon-192.png': (1024, 1024), # App Store / Marketing
}

print("Generating iOS app icons...")
for filename, size in sizes.items():
    resized = img.resize(size, Image.Resampling.LANCZOS)
    output_path = os.path.join(icon_dir, filename)
    resized.save(output_path, 'PNG')
    print(f"  ✓ {filename} - {size[0]}x{size[1]}")

# Splash screen logo
print("\nGenerating splash screen logo...")
splash_resized = img.resize((512, 512), Image.Resampling.LANCZOS)
splash_path = os.path.join(splash_dir, 'logo.png')
splash_resized.save(splash_path, 'PNG')
print(f"  ✓ logo.png - 512x512")

print("\n✅ Done! Icons and splash screen updated.")
