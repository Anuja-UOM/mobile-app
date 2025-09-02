# Deployment Guide for Flutter Mobile App

## Overview
This guide explains how to deploy your Flutter web app with Firebase Realtime Database integration to Firebase Hosting.

## Latest Changes
✅ **Firebase Realtime Database Integration**
- Replaced Cloud Firestore with Firebase Realtime Database
- App now saves only longitude and latitude coordinates
- Updated Firebase configuration for all platforms
- Added proper database URL configuration

## Prerequisites
1. Firebase CLI installed (`npm install -g firebase-tools`)
2. Flutter SDK installed and configured
3. Access to Firebase project: `mobile-app-location-b5ce8`

## Build and Deploy Steps

### 1. Build the Web App
```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for web (production)
flutter build web --release
```

### 2. Deploy to Firebase Hosting
```bash
# Login to Firebase (one-time setup)
firebase login

# Deploy to hosting
firebase deploy --only hosting
```

### 3. Alternative Deployment (if Firebase CLI issues)
```bash
# Build with specific base href
flutter build web --release --base-href /

# Manually upload build/web folder to Firebase Console
# Go to: https://console.firebase.google.com/project/mobile-app-location-b5ce8/hosting
```

## Project Configuration
- **Firebase Project ID**: `mobile-app-location-b5ce8`
- **Database URL**: `https://mobile-app-location-b5ce8-default-rtdb.asia-southeast1.firebasedatabase.app`
- **Hosting Directory**: `build/web`
- **Deploy URL**: Will be shown after successful deployment

## Key Features in Latest Version
- 📍 Location tracking with GPS coordinates
- 🔥 Firebase Realtime Database integration
- 💾 Saves only longitude, latitude, and timestamp
- 🌐 Progressive Web App (PWA) support
- 📱 Mobile-responsive design
- ⚡ Real-time data synchronization

## Database Structure
```json
{
  "locations": {
    "device_123456789": {
      "latitude": 37.7749,
      "longitude": -122.4194,
      "timestamp": 1625097600000
    }
  }
}
```

## Verification Steps
1. Open the deployed app URL
2. Grant location permissions
3. Click "Start Tracking"
4. Verify location data appears in Firebase Console
5. Check that only longitude/latitude are saved

## Troubleshooting
- If Firebase CLI login fails, use `firebase login --no-localhost`
- If build fails, run `flutter doctor` to check setup
- If deployment fails, verify Firebase project permissions
- For database connection issues, check Firebase Rules

## Production Checklist
- [ ] Flutter web build successful
- [ ] Firebase project configured
- [ ] Database rules set appropriately
- [ ] HTTPS enabled for location permissions
- [ ] PWA manifest configured
- [ ] Performance optimization applied
