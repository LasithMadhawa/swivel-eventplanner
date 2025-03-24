# Event Planner App  

A Flutter-based event planning application with Firebase integration, built using the BLoC pattern for state management.  

## Features  
- **Authentication**: Firebase Authentication (Email/Password)  
- **Database**: Firestore for data storage  
- **Storage**: Firebase Storage for managing profile pictures  
- **State Management**: BLoC pattern for structured and scalable app architecture  
- **Event Management**: View event details, organizers and posts  
- **Image Uploads**: Store and retrieve profile pictures from Firebase Storage  
- **Notifications**: Push notifications (Firebase Cloud Messaging)

## Tech Stack  
- **Flutter**: UI development  
- **Firebase Authentication**: User authentication  
- **Cloud Firestore**: NoSQL database for event data  
- **Firebase Storage**: Storing images and files  
- **BLoC (flutter_bloc)**: State management  

## Installation  
1. Clone the repository:
   ```sh
   git clone https://github.com/LasithMadhawa/swivel-eventplanner.git 
   cd swivel-eventplanner
   
2. Install dependencies:
    
        flutter pub get  

3. Configure Firebase:
    - Add the google-services.json (Android) and GoogleService-Info.plist (iOS) files in the appropriate folders.
    - Enable Firestore, Firebase Authentication, and Firebase Storage in your Firebase project.
    
4. Generate `firebase_options.dart`
    
    The `firebase_options.dart` file is required but is not committed to version control for security reasons. Generate it using:
    
        flutterfire configure

    
5. Run the application:

        flutter run  
        
## Testing 
Run all tests:
    
    flutter test