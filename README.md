# flutter_template 

flutter_template is a guide to setup a new flutter application with google-sign in firebase authentication and a simple bottom nav bar with routes.

## Preparing your machine

1. Make sure you have installed the [Flutter SDK](https://docs.flutter.dev/get-started/install) and [Visual Stufio Code](https://code.visualstudio.com/). Other editors will work but for the purpose of this tutorial I will be using Visual Studio Code.

2. If you have not already downloaded the Flutter extension in Visual Studio Code then do so now.<br>
Search for extension `Dart-Code.flutter`

## Creating a new Flutter application

I am using Visual Studio Code on a Windows 11 machine for this tutorial.

1. Open the Command Palette `View -> Command Palette` or `Ctrl+Shift+P` and search for `Flutter: New Project`

2. Proceed through the prompts and choose where to save the new Flutter project.<br> With that done, you will have your Flutter starter project, famously known as the counter application, created.

## Create and setup new Firebase project for Android

1. goto ``` https://console.firebase.google.com/u/0/ ```

2. select ```Add Project```

3. enter new project name ( example: ```fluttertemplate``` )

4. click ```Android icon``` to initilize Android setup.

5. locate package name at ``` android/app/build.grade ```  variable name applicationId ( example: ``` com.example.flutter_template ``` )

6. create ```appnickname```

7. for SHA information see the section below **[Authenticating Your Client](#authenticatingyourclient)**

8. Goto Firebase home -> build -> authentication -> sign-in method and enable google signing.

9. Navigate home -> build -> Firestore Database and create a database. Click on the **Rules** tab and change the rule to:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Connecting to Firebase Services

You no longer need to manually add the google-services.json file to Android and the GoogleService-Info.plist file to the iOS runner directory.

1. Go to [firebase.google.com](firebase.google.com) and create a new Firebase project. Enter your project name, disable Google Analytics for now, and click on the Create Project button.

2. Run this command from the root of your project in the terminal window (`Terminal -> New Terminal`) to add the Firebase core plugin:<br>
`flutter pub add firebase_core`

3. Using the [Flutter Fire documentation](https://firebase.google.com/docs/flutter/setup?platform=android), you can now initialize Firebase directly from Dart. To begin we need to install the [Firebase CLI](https://firebase.google.com/docs/cli). Follow the instructions in the link. Read through my [stackoverflow](https://stackoverflow.com/a/77000412/6401570) answer before installing on windows.

4. Once Firebase CLI is working properly we need to run two more commands:
    - `dart pub global activate flutterfire_cli`<br>
    and 
    - `flutterfire configure` <br>
After running this command and connecting to your Firebase project, you will see that the firebase_options.dart file has been created in your project structure, containing all the necessary information.

----
> Dont do this step if you did the flutterfire configure.

If you would connect to firebase using the SDK instrictions from Firebase by downloaded the google-services.json... note the alterations made from their documentation.<br><br>

1. The `project level build.gradle` documentation states to add 
```
plugins {
  // ...

  // Add the dependency for the Google services Gradle plugin
  id("com.google.gms.google-services") version "4.3.15" apply false

}
```
This produced erros and did not work. Insead I have added it to the dependencies...
```
dependencies {
    classpath 'com.android.tools.build:gradle:7.1.2'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    classpath 'com.google.gms:google-services:4.3.15'
}
```

2. For the `app level build.gradle` ensure you make the following changes.

insert new plugin and dependencies ( from firebase install guide )
```
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
      // Add the Google services Gradle plugin
    id("com.google.gms.google-services")

}

...

dependencies {
  implementation platform('com.google.firebase:firebase-bom:32.3.1')
  implementation 'com.google.firebase:firebase-analytics-ktx'
}
```

## Enable multiDex and min sdk version

In the  `app level build.gradle` ensure you make the following changes.
```
defaultConfig {
    ...
    multiDexEnabled true
    minSdkVersion 19
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}

```
## update pubsec.yaml

1. Add dependencies to ``` pubsec.yaml ``` file.

```
dependencies:
  flutter:
    sdk: flutter
    
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  firebase_core: ^2.15.1
  firebase_auth: ^4.9.0
  google_sign_in: ^6.1.5
  cloud_firestore: ^4.9.1
  provider: ^6.0.5
```

Open the terminal and run<br>
```
flutter pub get 

and

`flutter pub upgrade --major-versions `
```
to update changes.


2. Add assets to ``` pubsec.yaml ``` file.

```
# To add assets to your application, add an assets section, like this:
assets:
  - assets/
```


## Overwrite Files from this repo

Download this repo and replace your project's ``` lib ``` and ``` assets ``` folders from the downloaded repo.

Go trough each file and change all ``` import 'package:<project name> ``` refrences in all files in folders
  - test
  - lib
  - assets


## Connecting to git

If you want to sync to a git reposetory make sure you add the following to .gitignore:

```
ios/Runner/GoogleService-Info.plist
google-services.json
*.exe
```

## Test

Test the application out on an emulator.


## FAQ

1. Google Sign-in not working

    1. Make sure your google-services.json is inside `android/app/` directory.
  
    2. If you are reusing a Firebase project ensure you have the correct SHA1 key in Firebase. Then download google-services.json and update.