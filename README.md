
# GrandAccessModifier and Permission

## Overview

This project contains two main components: `GrandAccessModifier` and `Permission`. These components are designed to help manage permissions and display alerts within a SwiftUI application.

### GrandAccessModifier

`GrandAccessModifier` is a SwiftUI view modifier that presents an alert to the user, prompting them to change their app settings if necessary.

### Permission

`Permission` is a utility struct that provides methods for checking and requesting permissions for accessing contacts and the camera.

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

- **title**: The title of the alert.
- **message**: The main message of the alert.
- **showingAlert**: A binding to control the visibility of the alert.
- **url**: The URL to open when the settings button is pressed. Defaults to the app settings URL.

### Permission

- **isContactsGranted**: Checks if contacts access is granted.
- **isCameraGranted**: Checks if camera access is granted.
- **requestContactsAccess**: Requests access to contacts (used internally).
- **requestCameraAccess**: Requests access to the camera (used internally).

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
