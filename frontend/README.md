# Indicator Insight Flutter App

Indicator Insight Flutter App is a mobile application that provides access to financial indicators and analysis tools. It interacts with a backend API to fetch data and provide insights to users.

## Table of Contents

- [Indicator Insight Flutter App](#indicator-insight-flutter-app)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Languajes](#languajes)
  - [Authentication](#authentication)

## Prerequisites

Before running the Indicator Insight Flutter App, ensure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio / Xcode for iOS development

## Installation

1. Clone this repository to your local machine

## Usage

To run the Indicator Insight Flutter App:

1. Open the project in your preferred IDE (e.g., Android Studio, VS Code).
2. Ensure your device or emulator is connected.
3. Run the app using the IDE's run or debug command.
4. The app will start and load data from the backend API.

## Languajes

The app supports localization in English (`en`) and Spanish (`es`). Localization files are located in the `l10n/` directory:

- **l10n/**
  - **en.arb**: Localization resources for English language.
  - **es.arb**: Localization resources for Spanish language.

Ensure these files are correctly configured to provide translated content throughout the app.


## Authentication

The app uses a simple authentication mechanism managed by AuthTokenProvider using shared preferences to persist the authentication token.