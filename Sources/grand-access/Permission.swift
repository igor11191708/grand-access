//
//  Permission.swift
//
//
//  Created by Igor Shel on 13.07.2023.
//

import AVFoundation
import Contacts

/// A utility struct for checking and requesting permissions for camera and contacts.
public struct Permission {
    
    // MARK: - Contacts
    
    /// Checks if contacts access is granted.
    public static var isContactsGranted : Bool{
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
        get async{
            do{
               return try await CNContactStore().requestAccess(for: .contacts)
            }catch{
                return false
            }
        }
    }
    
    // MARK: - Camera
    
    /// Checks if camera access is granted.
   public static var isCameraGranted : Bool{
        get async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:  return true
                case .notDetermined: return await Permission.requestCameraAccess
                default:  return false
            }
        }
    }
    
    /// Requests access to the camera.
    static var requestCameraAccess: Bool {
        get async{
            await withCheckedContinuation{ continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
        }
    }
}
