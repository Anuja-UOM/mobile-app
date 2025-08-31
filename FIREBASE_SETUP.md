# Firebase Configuration Guide

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: "mobile-app-location"
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Add Android App

1. Click "Add app" → Android
2. Enter package name: `com.example.mobileApp`
3. Download `google-services.json`
4. Place it in `android/app/` directory

## Step 3: Add iOS App

1. Click "Add app" → iOS
2. Enter bundle ID: `com.example.mobileApp`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

## Step 4: Enable Firestore

1. Go to Firestore Database
2. Click "Create database"
3. Choose "Start in test mode"
4. Select a location close to your users
5. Click "Done"

## Step 5: Configure Security Rules

Replace Firestore rules with:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /locations/{document} {
      allow read, write: if true; // Change this for production
    }
  }
}
```

## Required Files (Download from Firebase Console):
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

## Test Data Structure:
```
locations (collection)
  └── device_id (document)
      ├── latitude: double
      ├── longitude: double
      ├── timestamp: timestamp
      ├── accuracy: double
      └── address: string (optional)
```
