# Guava

Guava is a Flutter-based front-end application that displays articles on nutrition and sports. The application's name stems from the vibrant "Guava" graphical identity. The main features of the application include viewing lists of articles, liking articles and adding them to favorites, displaying the details of an article, multi-language management through the NestJS backend, as well as global state management using Flutter's BlocBuilder.

## Initial Setup

### 1. Clone the repository

Start by cloning this repository to your local machine.

```shell
git clone https://github.com/DuncanTilliole/guava
```

### 2. Install dependencies

Navigate to the project directory and install the necessary dependencies:

```shell
cd guava/front
flutter pub get
```

### 3. Setup Firebase

This application uses Firebase, so you'll need to create a firebase_options.dart file with your Firebase configuration. For security reasons, this file is not included in the repository.

Create a new firebase_options.dart file in the lib/config/ directory, and add your Firebase configuration like so:

```dart
const firebaseOptions = const FirebaseOptions(
  apiKey: "your-api-key",
  authDomain: "your-auth-domain",
  databaseURL: "your-database-url",
  projectId: "your-project-id",
  storageBucket: "your-storage-bucket",
  messagingSenderId: "your-messaging-sender-id",
  appId: "your-app-id",
);
```

### 4. Set up the .env file

This application needs to know the IP address or DNS of the backend to fetch the articles. Create a .env file in the ./assets/env directory and add the backend's URL:

```dart
DATABASE_URL=http://your-backend-url
```

### 5. Run the backend server

This application requires a running instance of the NestJS backend server. Please refer to the backend repository for instructions on how to set it up and run it.

### 6. Run the app

Finally, you can run the application:

```shell
flutter run
```

Enjoy using Guava!

Remember, if you encounter any problems or have any suggestions, feel free to open an issue or a pull request.

Made by TILLIOLE DUNCAN