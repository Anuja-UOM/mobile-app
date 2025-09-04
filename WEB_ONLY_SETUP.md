# Web-Only Flutter Location Tracker

This Flutter application has been optimized for **web-only deployment** with all mobile platform dependencies removed.

## 🌐 **What's Included**

### ✅ **Web-Compatible Features**
- **Location Tracking**: GPS location services using `geolocator` (web-compatible)
- **Firebase Integration**: Real-time database for storing location data
- **Progressive Web App**: Full PWA configuration with service worker
- **Vicinity Notifications**: Browser-based notifications when moving >10 meters
- **Responsive UI**: Modern Material Design with Google Fonts

### 🗂️ **Project Structure**
```
mobile-app/
├── lib/
│   ├── main.dart              # Main app with location tracking & notifications
│   └── firebase_options.dart  # Firebase configuration
├── web/
│   ├── index.html            # PWA-optimized web entry point
│   ├── manifest.json         # PWA manifest for app installation
│   ├── sw.js                 # Service worker for offline functionality
│   ├── firebase-config.js    # Firebase web configuration
│   └── icons/               # PWA app icons
├── public/
│   └── index.html           # Firebase hosting index
├── firebase.json            # Firebase hosting configuration
├── pubspec.yaml            # Web-only dependencies
└── deploy.bat              # Deployment script
```

### 📦 **Dependencies (Web-Only)**
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.3.0        # Firebase web SDK
  firebase_database: ^11.0.4   # Realtime database for web
  geolocator: ^12.0.0          # Location services (web-compatible)
  google_fonts: ^6.2.1         # Typography
```

## 🚀 **Deployment**

### **Firebase Hosting**
```bash
flutter build web
firebase deploy
```

### **Local Development**
```bash
flutter run -d chrome
```

## 🔔 **Vicinity Notifications**

The app uses **browser notifications** instead of mobile push notifications:
- Requests permission when first notification is triggered
- Shows desktop notifications when user moves >10 meters
- Web-compatible across all modern browsers

## 📱 **PWA Installation**

Users can install this as a native-like app:
1. **Desktop**: Chrome will show "Install" button in address bar
2. **Mobile**: Safari → Share → "Add to Home Screen"
3. **Standalone Mode**: Runs full-screen without browser UI

## 🔧 **Removed Platform Files**

The following platform-specific files/folders were removed:
- `android/` - Android platform code
- `ios/` - iOS platform code  
- `linux/` - Linux platform code
- `macos/` - macOS platform code
- `windows/` - Windows platform code
- `test/` - Platform-specific tests
- Mobile-specific dependencies and configurations

## 🌍 **Browser Compatibility**

- ✅ Chrome/Chromium (recommended)
- ✅ Firefox
- ✅ Safari
- ✅ Edge
- ✅ Mobile browsers with PWA support

## 📍 **Location Services**

- **Web Geolocation API**: Uses browser's built-in GPS/location services
- **High Accuracy**: Configured for precise location tracking
- **Automatic Updates**: Every 5 seconds when tracking is active
- **Distance Calculation**: Accurate distance measurement between positions

---

**Note**: This is now a pure web application optimized for deployment as a Progressive Web App with location tracking and vicinity notification capabilities.
