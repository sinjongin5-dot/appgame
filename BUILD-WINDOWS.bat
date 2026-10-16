@echo off
setlocal
where node >nul 2>nul || (echo Node.js 20+ is required.& pause & exit /b 1)
call npm install || (echo npm install failed.& pause & exit /b 1)
if not exist android\settings.gradle if not exist android\settings.gradle.kts (
  call npx cap add android || (echo Android project creation failed. Install Android Studio and retry.& pause & exit /b 1)
)
call npx cap sync android || (echo Capacitor sync failed.& pause & exit /b 1)
call npx cap open android
