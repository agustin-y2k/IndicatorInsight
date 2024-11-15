# Indicator Insight Flutter App

<<<<<<< HEAD
Indicator Insight Flutter App is a mobile application that provides access to financial indicators and analysis tools. It interacts with a backend API to fetch data and provide insights to users.
=======
Indicator Insight Flutter App is a mobile application that provides access to financial indicators and analysis tools.
It interacts with a backend API to fetch data and provide insights to users.
>>>>>>> develop

## Table of Contents

- [Indicator Insight Flutter App](#indicator-insight-flutter-app)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
<<<<<<< HEAD
  - [Languajes](#languajes)
  - [Authentication](#authentication)
=======
  - [Features](#features)
  - [Localization](#localization)
  - [Authentication](#authentication)
  - [Screens](#screens)
>>>>>>> develop

## Prerequisites

Before running the Indicator Insight Flutter App, ensure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio / Xcode for iOS development

## Installation

<<<<<<< HEAD
1. Clone this repository to your local machine
=======
1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Check available devices:
   ```bash
   flutter devices
   ```

3. Run the app on an emulator or connected device:
   ```bash
   flutter run
   ```
>>>>>>> develop

## Usage

To run the Indicator Insight Flutter App:

1. Open the project in your preferred IDE (e.g., Android Studio, VS Code).
2. Ensure your device or emulator is connected.
<<<<<<< HEAD
3. Run the app using the IDE's run or debug command.
4. The app will start and load data from the backend API.

## Languajes
=======
3. Use the IDE's run or debug command to start the app.
4. Explore financial indicators, user authentication, and insights provided by the app.

## Features

- **Financial Indicators**: Includes RSI, MACD, ADX, Bollinger Bands, and more.
- **User Authentication**: Secure login, registration, and password reset functionality.
- **Indicator Analysis**: Dedicated screens for data input, chart visualization, and analysis for each financial indicator.
- **Help and Documentation**: Provides a help section for each indicator to guide users on interpretation and usage.

## Localization
>>>>>>> develop

The app supports localization in English (`en`) and Spanish (`es`). Localization files are located in the `l10n/` directory:

- **l10n/**
  - **en.arb**: Localization resources for English language.
  - **es.arb**: Localization resources for Spanish language.

Ensure these files are correctly configured to provide translated content throughout the app.

<<<<<<< HEAD

## Authentication

The app uses a simple authentication mechanism managed by AuthTokenProvider using shared preferences to persist the authentication token.
=======
## Authentication

The app uses a secure authentication mechanism managed by `AuthTokenProvider`, which utilizes shared preferences to persist the authentication token.

## Screens

The app consists of the following key screens:

- **Authentication Screens**:
  - `LoginScreen`
  - `RegisterScreen`
  - `ForgotPasswordScreen`
  - `EnterResetCodeScreen`
  - `ResetPasswordScreen`
- **Home and Navigation**:
  - `HomeScreen`
  - `IndicatorSelectionScreen`
- **Indicator Screens**:
  - RSI (Relative Strength Index):
    - `RsiInputScreen`
    - `RsiHelpScreen`
    - `RsiChartScreen`
    - `RsiAnalysisScreen`
  - Similar screens exist for other indicators (MACD, ADX, etc.).

Each indicator screen is designed to guide the user through data input, analysis, help and chart visualization.
>>>>>>> develop
