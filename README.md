
# Grand access and Permission

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fgrand-access%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/The-Igor/grand-access) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fgrand-access%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/The-Igor/grand-access)

## Overview

This package contains two main components: `GrandAccessModifier` and `Permission`. These components are designed to help manage permissions and display alerts within a SwiftUI application.

## Features

### GrandAccessModifier
- [x] Customizable Alert: Allows setting custom titles and messages for alerts.
- [x] Settings Navigation: Provides a button to open the app’s settings directly from the alert.
- [x] Compatibility: Supports iOS 14 and later versions with appropriate alert handling.

### Permission
- [x] Asynchronous Permission Handling: Uses async/await for checking and requesting permissions.
- [x] Comprehensive Permission Management: Handles permissions for contacts, camera, mic and photo library.
- [x] Robust Error Handling: Includes basic error handling and logging for permission requests.


 ![simulate locations](https://github.com/The-Igor/grand-access/blob/main/img/grand_access.gif)

### GrandAccessModifier

`GrandAccessModifier` is a SwiftUI view modifier that presents an alert to the user, prompting them to change their app settings if necessary.

### Permission

`Permission` is a utility struct that provides methods for checking and requesting permissions for accessing 
    •    Camera
    •    Contacts
    •    Microphone
    •    Photo Library

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

## Installation

1. **Add Files to Your Project**: Copy the `GrandAccessModifier.swift` and `Permission.swift` files into your Xcode project.

2. **Import Modules**: Ensure you import the necessary modules in your Swift files.

```swift
import SwiftUI
import AVFoundation
import Contacts
```

## Documentation

### GrandAccessModifier

| Var or Method   | Description                                                |
|-----------------|------------------------------------------------------------|
| **title**       | The title of the alert.                                    |
| **message**     | The main message of the alert.                             |
| **showingAlert**| A binding to control the visibility of the alert.          |
| **url**         | The URL to open when the settings button is pressed. Defaults to the app settings URL. |

### Permission

| Var or Method               | Description                                           |
|-----------------------------|-------------------------------------------------------|
| **isContactsGranted**       | Checks if contacts access is granted.                 |
| **isCameraGranted**         | Checks if camera access is granted.                   |
| **isMicrophoneGranted**     | Checks if microphone access is granted.               |
| **isPhotoLibraryGranted**   | Checks if photo library access is granted.            |
| **requestContactsAccess**   | Requests access to contacts (used internally).        |
| **requestCameraAccess**     | Requests access to the camera (used internally).      |
| **requestMicrophoneAccess** | Requests access to the microphone (used internally).  |
| **requestPhotoLibraryAccess** | Requests access to the photo library (used internally). |

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
