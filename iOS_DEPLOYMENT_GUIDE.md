# iPhone App Deployment Guide

## Prerequisites

### Required Hardware/Software:
- **Mac computer** (MacBook, iMac, Mac Mini, or Mac Studio)
- **Xcode 15+** (free from Mac App Store)
- **Apple Developer Account** ($99/year for App Store deployment)
- **iPhone device** or use iPhone Simulator for testing

## Step 1: Prepare Your Project

### 1.1 Update Bundle Identifier
Replace `com.example.mobileApp` with your unique identifier:
```
com.yourcompany.mobileapp
```

### 1.2 Update App Information
In `ios/Runner/Info.plist`, update:
- `CFBundleDisplayName` - App name shown on device
- App icon and launch screen

## Step 2: Set Up Development Environment (on Mac)

### 2.1 Install Required Tools
```bash
# Install Xcode from Mac App Store
# Install Flutter on Mac
flutter doctor
```

### 2.2 Configure iOS Development
```bash
# Accept Xcode license
sudo xcodebuild -license accept

# Install iOS deployment tools
flutter doctor --android-licenses
```

## Step 3: Configure Apple Developer Account

### 3.1 Create Apple ID
- Go to [developer.apple.com](https://developer.apple.com)
- Sign up for Apple Developer Program ($99/year)

### 3.2 Configure Xcode Signing
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner target
3. Go to "Signing & Capabilities"
4. Select your Team
5. Update Bundle Identifier to your unique ID

## Step 4: Build and Deploy

### 4.1 Build for iOS Device
```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Build iOS app
flutter build ios --release
```

### 4.2 Deploy to iPhone
```bash
# Connect iPhone via USB
# Trust computer on iPhone
# Run on device
flutter run --release
```

### 4.3 Build for App Store
```bash
# Build for App Store
flutter build ipa --release

# Upload to App Store Connect using Xcode or Transporter
```

## Step 5: App Store Submission

### 5.1 App Store Connect
1. Create app in App Store Connect
2. Fill app information
3. Upload build using Xcode or Transporter
4. Submit for review

### 5.2 Required Assets
- App icon (1024x1024px)
- Screenshots for different device sizes
- App description and keywords
- Privacy policy (if required)

## Current Project Status

✅ Flutter project created with iOS support
✅ iOS folder structure in place
✅ Info.plist configured
⚠️ Bundle identifier needs to be updated
⚠️ App icons need to be added
⚠️ Requires Mac for building

## Next Steps for iPhone Deployment

1. **Transfer project to Mac** or use remote Mac service
2. **Update bundle identifier** to your unique ID
3. **Add app icons** and launch screens
4. **Test on iPhone Simulator**
5. **Build and deploy to physical iPhone**
6. **Submit to App Store** (optional)

## Alternative Solutions

### Cloud Build Services:
- **Codemagic** - CI/CD for Flutter with iOS builds
- **Bitrise** - Mobile CI/CD platform
- **GitHub Actions** with macOS runners

### Remote Mac Access:
- **MacStadium** - Rent Mac in the cloud
- **AWS EC2 Mac instances**
- **Scaleway Mac mini**

## Commands for Mac Development

```bash
# Check iOS development setup
flutter doctor

# List available iOS devices/simulators
flutter devices

# Run on iOS simulator
flutter run -d "iPhone 15 Pro"

# Build for iOS
flutter build ios --release

# Build IPA for App Store
flutter build ipa --release
```

## Important Notes

- iOS apps **must** be built on macOS due to Apple's licensing
- You need a Mac or Mac cloud service for iOS development
- Apple Developer Account required for device testing and App Store
- App Store review process typically takes 1-7 days
