# WealthFlow

> **👋 Welcome Reviewer / Recruiter!**
> Please see the [Reviewer / Recruiter Guide](#reviewer--recruiter-guide) below for quick start instructions.

A premium wealth management dashboard built with Flutter, featuring real-time net worth tracking, financial asset breakdowns, and an elegant onboarding experience.

## Reviewer / Recruiter Guide

To make reviewing this application as easy as possible, two modes of operation are supported:

### Option 1: Quick Review (Mock Dashboard - Recommended)
You can test the Flutter app UI and Dashboard without needing to configure or run the local Node.js/MongoDB backend.
1. Install dependencies: `flutter pub get`
2. Run the app: `flutter run`
3. Navigate to the **Sign Up** flow (Email -> Password).
4. On the **Password Input** screen, click the **"Skip Sign Up (Mock Dashboard)"** text button at the bottom.
5. You will instantly bypass the API and be routed to the Dashboard populated with rich, interactive mock data.

### Option 2: Full Stack Review (Real API)
If you wish to test the actual end-to-end API integration:
1. Open a separate terminal and navigate to the backend directory (`wealthflow_backend`).
2. Run `npm install` followed by `npm start` (ensuring MongoDB is running locally). The server will start on port `4000`.
3. In the root of the Flutter project (`wealthflow`), create a `.env` file and add your local base URLs:
   ```env
   IOS_BASE_URL=http://127.0.0.1:4000
   ANDROID_BASE_URL=http://10.0.2.2:4000
   ```
4. Run the Flutter app: `flutter run`
5. Proceed through the normal Sign Up flow.
6. Enter a valid password and click **"Set Password"** to trigger the real authentication API call to the backend.

## Tech Stack

| Category | Packages |
|---|---|
| State Management | `flutter_bloc`, `bloc`, `equatable` |
| Routing | `go_router` |
| Dependency Injection | `get_it`, `injectable` |
| Networking | `dio` |
| Local Storage | `hive_flutter`, `shared_preferences` |
| Environment | `flutter_dotenv` |
| UI | `fl_chart`, `flutter_svg`, `cached_network_image`, `shimmer` |

## Prerequisites

- Flutter SDK `>=3.3.5 <4.0.0`
- Dart SDK (bundled with Flutter)

## Features Overview

- **Splash Screen**: Animated logo slide and branding reveal.
- **Onboarding Intro**: Staggered animations introducing key features.
- **Authentication**: Regex-validated email and real-time password strength validation.
- **Dashboard**: Interactive net worth line chart (`fl_chart`), asset breakdowns, horizontal summary bars, and article carousels.
- **Clean Architecture**: Organized by core network layers, dependency injection, and feature-first presentation layers using `Bloc`.

## Helpful Commands

```bash
# Install dependencies
flutter pub get

# Generate code (injectable, freezed, flutter_gen)
dart run build_runner build --delete-conflicting-outputs

```
