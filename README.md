# GoldPlay Arena — Flutter starter

A free-to-play Android arcade prototype using a Green + Black + Gold theme.

## Included
- Home dashboard and bottom navigation
- Four game entry tiles: Lucky Reels, Rummy Practice, Mini Games, Sky Flight
- Practice score and a demo daily bonus (resets when app restarts)
- No real-money wagering, deposits, cash prizes, transfers or withdrawals

## Build using only an Android phone (cloud build)
1. Download and extract this ZIP using a file manager such as Files or ZArchiver.
2. In Chrome, open GitHub and create a new repository named `goldplay-arena`.
3. Upload the extracted project files and folders to the repository root. Make sure `lib/main.dart`, `pubspec.yaml`, and `.github/workflows/android.yml` are present at the root.
4. Open the repository's **Actions** tab.
5. Select **Build Android APK** and tap **Run workflow** (or upload/push to the `main` branch).
6. When the run finishes successfully, open that run, find **Artifacts**, and download `goldplay-arena-debug-apk`.
7. Extract the artifact ZIP to get `app-debug.apk`. Android may ask you to allow installation from that source. Only install builds from your own repository.

## Important
- This is a starter UI/demo, not a complete online multiplayer game or production-ready app.
- The APK produced is a debug/testing build, not a Play Store release.
- The demo points have no cash value. Do not add deposits, betting, cash prizes, transfers or withdrawals.
- Before public release, add secure authentication, server-side score validation, privacy disclosures, accessibility testing, support and store-policy review.
- The app name is a working title; check trademark and store-name availability before launch.
