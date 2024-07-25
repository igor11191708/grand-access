//
//  GrandAccessModifier.swift
//
//  Created by Igor Shel on 13.07.2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(WatchKit)
import WatchKit
#endif

/// Show grand access alert
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct GrandAccessModifier: ViewModifier {
    
    /// Text of title
    let title: LocalizedStringKey
    
    /// The main message
    let message: LocalizedStringKey
        
    /// Binding to on/off alert
    @Binding var showingAlert: Bool
    
    let url: URL?
    
    // MARK: - Life circle
    
    public init(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        showingAlert: Binding<Bool>,
        url: URL? = GrandAccessModifier.defaultSettingsURL
    ) {
        self.title = title
        self.message = message
        self.url = url
        self._showingAlert = showingAlert
    }
    
    public func body(content: Content) -> some View {
        if #unavailable(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0) {
            content
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(title, bundle: .module),
                          primaryButton: .default(Text("not_now", bundle: .module), action: { }),
                          secondaryButton: .default(Text("settings", bundle: .module), action: { onSettings() })
                    )
                }
        } else {
            content
                .alert(Text(title, bundle: .module), isPresented: $showingAlert) {
                    Button(action: {}, label: {
                        Text("not_now", bundle: .module)
                    })
                    Button("settings", role: .none) { onSettings() }
                } message: {
                    Text(message, bundle: .module)
                }
        }
    }
    
    private func onSettings() {
        if let url = url {
            #if os(iOS) || os(tvOS)
            UIApplication.shared.open(url)
            #elseif os(macOS)
            NSWorkspace.shared.open(url)
            #elseif os(watchOS)
            WKExtension.shared().openSystemURL(url)
            #endif
        }
    }
    
    public static var defaultSettingsURL: URL? {
        #if os(iOS) || os(tvOS)
        return URL(string: UIApplication.openSettingsURLString)
        #else
        return nil
        #endif
    }
}
