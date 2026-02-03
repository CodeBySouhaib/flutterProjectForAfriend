# ORM Risk Assessment - Flutter Version

A cross-platform Flutter application for risk assessment and reference tables, replicating the functionality of the original web application with a military-style UI theme.

## Features

### Risk Assessment Tab
- **Mission & Crew Information**: Input fields for pilot details, mission type, and date
- **Dynamic Risk Entry System**: Add multiple risk entries with real-time calculation
- **Risk Calculation**: Formula: Risk Value = Likelihood × Severity - Deduction
- **Risk Categories**: Automatic categorization (Low, Moderate, High, Very High, Extreme)
- **Form Validation**: Required field validation with visual feedback
- **Export Options**: PDF export functionality

### Reference Tables Tab
- **Likelihood Scale**: Definitions for Very Improbable to Frequent
- **Severity Scale**: Definitions for Negligible to Catastrophic
- **Risk Matrix**: Visual representation of risk scoring
- **Hazard Examples Manager**: Add, edit, and remove custom hazard examples
- **Categories**: Planning, Event/Mission, Asset/Resource, Comms/Supervision, Environment/Ground Facilities

### Data Persistence
- **Local Storage**: Uses shared_preferences for data persistence
- **Custom Hazard Examples**: Save and load custom hazard examples
- **Mission Details**: Persistent storage of mission information
- **Risk Entries**: Automatic saving of risk assessments

## Technology Stack

- **Flutter**: Cross-platform mobile and desktop development
- **Dart**: Programming language
- **Shared Preferences**: Local data storage
- **PDF Generation**: PDF and printing libraries for export
- **Path Provider**: File system access
- **Permission Handler**: Android permissions management

## Installation

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Android Studio or VS Code with Flutter extension
- For Windows builds: Visual Studio 2019 or later

### Setup Instructions

1. **Clone the repository** (if not already done)
2. **Navigate to the Flutter project directory**:
   ```bash
   cd flutter_orm_app
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

## Building for Production

### Android APK
```bash
# Build release APK
flutter build apk --release

# Build app bundle (recommended for Google Play)
flutter build appbundle --release
```

### Windows EXE
```bash
# Enable Windows desktop support (if not already enabled)
flutter config --enable-windows-desktop

# Build Windows executable
flutter build windows --release
```

### iOS (if needed)
```bash
# Enable iOS support
flutter config --enable-ios

# Build iOS app
flutter build ios --release
```

## Project Structure

```
flutter_orm_app/
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── models/                      # Data models
│   │   ├── risk_entry.dart          # Risk entry model
│   │   └── mission_details.dart     # Mission details model
│   ├── services/                    # Business logic and data handling
│   │   ├── data_service.dart        # Local storage management
│   │   └── export_service.dart      # PDF export functionality
│   ├── ui/                          # User interface screens
│   │   ├── main_app.dart            # Main app configuration
│   │   ├── home_page.dart           # Tabbed interface
│   │   ├── assessment_tab.dart      # Risk assessment screen
│   │   └── reference_tab.dart       # Reference tables screen
│   ├── utils/                       # Utility functions
│   │   └── risk_calculator.dart     # Risk calculation logic
│   └── widgets/                     # Reusable UI components
│       ├── mission_details_form.dart
│       ├── risk_entry_form.dart
│       ├── risk_summary.dart
│       └── hazard_examples_manager.dart
├── android/                         # Android-specific configuration
├── windows/                         # Windows-specific configuration
├── pubspec.yaml                     # Dependencies and assets
└── README.md                        # This file
```

## Key Components

### Models
- **RiskEntry**: Represents individual risk assessments with category, title, description, likelihood, severity, and deduction values
- **MissionDetails**: Stores pilot information, mission type, and date

### Services
- **DataService**: Handles local storage using shared_preferences
- **ExportService**: Manages PDF generation and export functionality

### UI Components
- **HomePage**: Main tabbed interface with bottom navigation
- **AssessmentTab**: Risk assessment functionality
- **ReferenceTab**: Reference tables and hazard examples management

### Widgets
- **MissionDetailsForm**: Form for entering mission and crew information
- **RiskEntryForm**: Individual risk entry with real-time calculation
- **RiskSummary**: Displays overall ORM risk and category
- **HazardExamplesManager**: Manages custom hazard examples

## Risk Calculation Logic

The application implements the same risk calculation as the original web app:

```
Risk Value = Likelihood × Severity - Deduction
Residual Risk Value = Risk Value - Deduction
```

### Risk Categories
- **1-4**: Low Risk
- **5-9**: Moderate Risk
- **10-14**: High Risk
- **15-20**: Very High Risk
- **21-25**: Extreme Risk

## Export Functionality

Currently supports PDF export with:
- Mission details
- All risk entries in tabular format
- Risk summary with ORM risk score
- Reference tables for likelihood and severity scales
- Professional military-style formatting

## Customization

### Theme Colors
The application uses a military-style color scheme:
- Primary: `#4A6741` (Military green)
- Background: `#1A1A1A` (Dark gray)
- Accent: `#B8D4A8` (Light green)

### Adding New Features
1. Create new models in `lib/models/`
2. Add business logic to `lib/services/`
3. Create UI components in `lib/widgets/` or `lib/ui/`
4. Update the main navigation as needed

## Troubleshooting

### Common Issues

1. **Flutter not found**: Ensure Flutter SDK is installed and added to PATH
2. **Android build fails**: Check Android SDK and NDK versions
3. **Windows build fails**: Ensure Visual Studio is properly configured
4. **Permissions issues**: Check AndroidManifest.xml for required permissions

### Dependencies
If you encounter dependency issues:
```bash
flutter pub cache repair
flutter pub get
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
1. Check the Flutter documentation
2. Review the original web application for reference
3. Create an issue in the repository