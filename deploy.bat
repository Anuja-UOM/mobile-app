@echo off
echo ========================================
echo  Flutter Mobile App Deployment Script
echo ========================================
echo.

echo Step 1: Cleaning previous builds...
call flutter clean
if %ERRORLEVEL% neq 0 (
    echo Error: Flutter clean failed
    pause
    exit /b 1
)

echo.
echo Step 2: Getting dependencies...
call flutter pub get
if %ERRORLEVEL% neq 0 (
    echo Error: Flutter pub get failed
    pause
    exit /b 1
)

echo.
echo Step 3: Building web app for production...
call flutter build web --release
if %ERRORLEVEL% neq 0 (
    echo Error: Flutter build failed
    pause
    exit /b 1
)

echo.
echo Step 4: Deploying to Firebase Hosting...
call firebase deploy --only hosting --project mobile-app-location-b5ce8
if %ERRORLEVEL% neq 0 (
    echo Error: Firebase deployment failed
    echo Please check if you're logged in: firebase login
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Deployment completed successfully!
echo ========================================
echo.
echo Your app should now be available at:
echo https://mobile-app-location-b5ce8.web.app
echo.
pause
