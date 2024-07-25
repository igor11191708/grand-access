//
//  Permission.swift
//
//
//  Created by Igor Shel on 13.07.2023.
//

#if canImport(AVFoundation)
import AVFoundation
#endif

#if canImport(Contacts)
import Contacts
#endif

#if canImport(Photos)
import Photos
#endif

/// A utility struct for checking and requesting permissions for camera, contacts, and more
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct Permission {
    
    // MARK: - Contacts
    #if canImport(Contacts)
    /// Checks if contacts access is granted.
    public static var isContactsGranted: Bool {
        get async {
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:  return true
            case .notDetermined: return await Permission.requestContactsAccess
            default:  return false
            }
        }
    }
    
    /// Requests access to contacts.
    static var requestContactsAccess: Bool {
        get async {
            do {
                return try await CNContactStore().requestAccess(for: .contacts)
            } catch {
                return false
            }
        }
    }
    #endif
    
    // MARK: - Camera
    #if canImport(AVFoundation) && !os(watchOS)
    /// Checks if camera access is granted.
    @available(tvOS 17.0, *)
    public static var isCameraGranted: Bool {
        get async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:  return true
            case .notDetermined: return await Permission.requestCameraAccess
            default:  return false
            }
        }
    }
    
    /// Requests access to the camera.
    @available(tvOS 17.0, *)
    static var requestCameraAccess: Bool {
        get async {
            await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
        }
    }
    #endif

    // MARK: - Microphone
    #if canImport(AVFoundation) && !os(macOS) && !os(tvOS)
    /// Checks if microphone access is granted.
    public static var isMicrophoneGranted: Bool {
        get async {
            switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                return true
            case .undetermined:
                return await Permission.requestMicrophoneAccess
            default:
                return false
            }
        }
    }
    
    /// Requests access to the microphone.
    public static var requestMicrophoneAccess: Bool {
        get async {
            await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        }
    }
    #endif
    
    // MARK: - Photo Library
    #if canImport(Photos)
    /// Checks if photo library access is granted.
    public static var isPhotoLibraryGranted: Bool {
        get async {
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                return true
            case .notDetermined:
                return await Permission.requestPhotoLibraryAccess
            default:
                return false
            }
        }
    }
    
    /// Requests access to the photo library.
    public static var requestPhotoLibraryAccess: Bool {
        get async {
            await withCheckedContinuation { continuation in
                PHPhotoLibrary.requestAuthorization { status in
                    continuation.resume(returning: status == .authorized)
                }
            }
        }
    }
    #endif
}
