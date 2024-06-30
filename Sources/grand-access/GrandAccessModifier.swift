//
//  GrandAccessModifier.swift
//
//  Created by Igor Shel on 13.07.2023.
//

import SwiftUI

/// Show grand access alert
@available(iOS 14.0, *)
public struct GrandAccessModifier: ViewModifier {
    
    /// Text of title
    let title : LocalizedStringKey
    
    /// The main message
    let message : LocalizedStringKey
        
    /// Binding to on\of alert
    @Binding var showingAlert : Bool
    
    let url : URL?
    
    // MARK: - Life circle
    
    public init(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        showingAlert: Binding<Bool>,
        url : URL? = URL(string: UIApplication.openSettingsURLString)
    ) {            
        self.title = title
        self.message = message
        self.url = url
        self._showingAlert = showingAlert
    }
    
    public func body(content: Content) -> some View {
        if #unavailable(iOS 16.0) {
            content
                .alert(isPresented: $showingAlert){
                    Alert(title: Text(title, bundle: .module),
                          primaryButton: .default(  Text("not_now", bundle: .module) , action: { }),
                          secondaryButton: .default( Text("settings", bundle: .module) , action: { onSettings()} )
                    )
                }
        }else{
            content
                .alert(Text(title, bundle: .module), isPresented: $showingAlert) {
                    Button(action: {}, label: {
                        Text("not_now", bundle: .module) })
                    Button("settings", role: .none) { onSettings() }
                }
            message: {
                Text(message, bundle: .module)
            }
        }
    }
    
    private func onSettings(){
        if let url = url {
            UIApplication.shared.open(url)
        }
    }
}
