//
//  Permission.swift
//
//
//  Created by Igor Shel on 13.07.2023.
//

import AVFoundation
import Contacts

public struct Permission {
    
    // MARK: - Contacts
    
    public static var isContactsGranted : Bool{
         get async {
             switch CNContactStore.authorizationStatus(for: .contacts) {
                 case .authorized:  return true
                 case .notDetermined: return await Permission.requestContactsAccess
                 default:  return false
             }
         }
     }
    
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
    
   public static var isCameraGranted : Bool{
        get async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:  return true
                case .notDetermined: return await Permission.requestCameraAccess
                default:  return false
            }
        }
    }

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
