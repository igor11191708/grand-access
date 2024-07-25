# Grand access and Permission async/await

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fgrand-access%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/The-Igor/grand-access) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fgrand-access%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/The-Igor/grand-access)

## Why ?! instead of a preface
So, while working on some projects, I kept running into designs that needed the rights request functions to be in different visual components. Instead of copying and pasting the same code everywhere, I decided to streamline things by pulling that functionality into its own package.

I’ve decided to separate certain permission-acquiring functionalities within my projects because each type of permission has its unique implementation requirements. I might even consider placing each of them in a separate package. I will think about this later based on practical experience.

### SwiftUI example
The project demonstrating how to handle camera permissions in an iOS application [here](https://github.com/The-Igor/permission-swift-example)

### CoreLocation
Explore the [**Async location**](https://github.com/The-Igor/d3-async-location) repository on GitHub. It provides practical examples on how to set up and manage permissions for location services in iOS applications.

## Overview

This package contains two main components: `GrandAccessModifier` and `Permission`. These components are designed to help manage permissions and display alerts within a SwiftUI application.

## Features

### Request access for
- **Camera**: iOS, macOS, tvOS (tvOS 17.0+)
- **Contacts**: iOS, macOS, watchOS
- **Microphone**: iOS, watchOS
- **Photo Library**: iOS, macOS, tvOS

### GrandAccessModifier
- [x] Customizable Alert: Allows setting custom titles and messages for alerts.
- [x] Settings Navigation: Provides a button to open the app’s settings directly from the alert.
- [x] Compatibility: Supports iOS 14, macOS 11, tvOS 14, watchOS 7 and later versions with appropriate alert handling.

### Permission
- [x] Asynchronous Permission Handling: Uses async/await for checking and requesting permissions.
- [x] Robust Error Handling: Includes basic error handling and logging for permission requests.


 ![simulate locations](https://github.com/The-Igor/grand-access/blob/main/img/grand_access.gif)

## Usage

### GrandAccessModifier

To use `GrandAccessModifier`, apply it to any SwiftUI view. This modifier will display an alert when the `showingAlert` binding is set to `true`.

#### Example:

```swift
import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        VStack {
            Text("Hello, World!")
                .modifier(GrandAccessModifier(
                    title: "Access Required",
                    message: "This app requires access to your settings.",
                    showingAlert: $showingAlert
                ))

            Button("Show Alert") {
                showingAlert = true
            }
        }
    }
}
```

### Permission

`Permission` provides asynchronous properties to check if access to contacts or the camera has been granted, and methods to request access if it hasn't.

#### Example:

##### Permission Keys and Descriptions
Add to Info.plist file to include the necessary permission descriptions:

| NS Key | Key | Description |
|--------|-----|-------------|
| `NSCameraUsageDescription` | Privacy - Camera Usage Description| A string that describes why your app needs access to the camera. This is displayed in the permission dialog. |
| `NSContactsUsageDescription` | Privacy - Contacts Usage Description| A string that explains why your app needs access to the user’s contacts. |
| `NSMicrophoneUsageDescription` | Privacy - Microphone Usage Description| A string that details why your app requires access to the microphone. |
| `NSPhotoLibraryUsageDescription` | Privacy - Photo Library Usage Description| A string that justifies why your app needs access to the photo library. |

##### Example Descriptions:

- **Camera**: "This app uses the camera to let you take photos to personalize your profile."
- **Contacts**: "Access to contacts is used for quickly inviting your friends to join the app."
- **Microphone**: "The microphone access is needed for voice chats in your conversations."
- **Photo Library**: "This app accesses your photo library for uploading images to your account."

```swift

import AVFoundation
import Contacts
import Photos

// Check if contacts access is granted
let isContactsGranted = await Permission.isContactsGranted

// Request contacts access if not granted
if !isContactsGranted {
    let granted = await Permission.requestContactsAccess
    if granted {
        // Access granted
    } else {
        // Access denied
    }
}

// Similarly, check and request access for Camera, Microphone, and Photo Library
let isCameraGranted = await Permission.isCameraGranted
let isMicrophoneGranted = await Permission.isMicrophoneGranted
let isPhotoLibraryGranted = await Permission.isPhotoLibraryGranted
```

```swift

import SwiftUI

struct PermissionView: View {
    @State private var isCameraGranted = false
    @State private var isContactsGranted = false

    var body: some View {
        VStack {
            Button("Check Camera Permission") {
                Task {
                    isCameraGranted = await Permission.isCameraGranted
                    print("Camera Access: \(isCameraGranted)")
                }
            }

            Button("Check Contacts Permission") {
                Task {
                    isContactsGranted = await Permission.isContactsGranted
                    print("Contacts Access: \(isContactsGranted)")
                }
            }
        }
    }
}
```

## Documentation

### GrandAccessModifier

| Var  | Description                                                |
|-----------------|------------------------------------------------------------|
| **title**       | The title of the alert.                                    |
| **message**     | The main message of the alert.                             |
| **showingAlert**| A binding to control the visibility of the alert.          |
| **url**         | The URL to open when the settings button is pressed. Defaults to the app settings URL. |

### Permission

| Method                 | Description                                           | Access   |
|-------------------------------|-------------------------------------------------------|----------|
| **isContactsGranted**         | Checks if contacts access is granted.                 | public   |
| **isCameraGranted**           | Checks if camera access is granted.                   | public   |
| **isMicrophoneGranted**       | Checks if microphone access is granted.               | public   |
| **isPhotoLibraryGranted**     | Checks if photo library access is granted.            | public   |
| **requestContactsAccess**     | Requests access to contacts.        | internal |
| **requestCameraAccess**       | Requests access to the camera.      | internal |
| **requestMicrophoneAccess**   | Requests access to the microphone.  | internal |
| **requestPhotoLibraryAccess** | Requests access to the photo library. | internal |


## License

This project is licensed under the MIT License. See the LICENSE file for more details.

