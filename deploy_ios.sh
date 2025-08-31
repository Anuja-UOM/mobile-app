#!/bin/bash

# iOS Deployment Script for Flutter App
# Run this on macOS after transferring the project

echo "🚀 Flutter iOS Deployment Script"
echo "================================"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script must be run on macOS for iOS development"
    exit 1
fi

# Check Flutter installation
echo "📱 Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Please install Flutter first."
    exit 1
fi

# Run Flutter doctor
echo "🔍 Running Flutter doctor..."
flutter doctor

# Check for iOS development setup
echo "🍎 Checking iOS development setup..."
flutter doctor --check-ios

# Clean and get dependencies
echo "🧹 Cleaning project..."
flutter clean
flutter pub get

# Check available iOS devices
echo "📱 Available iOS devices:"
flutter devices

# Build for iOS (will require code signing on Mac)
echo "🔨 Building iOS app..."
read -p "Do you want to build for iOS? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    flutter build ios --release
fi

# Run on iOS simulator
echo "📱 Would you like to run on iOS simulator?"
read -p "Run on simulator? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    flutter run -d "iPhone 15 Pro"
fi

echo "✅ iOS deployment script completed!"
echo "Next steps:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Configure signing & capabilities"
echo "3. Update bundle identifier"
echo "4. Test on physical device"
echo "5. Build for App Store submission"
