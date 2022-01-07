//
//  ContentView.swift
//  BiotmetricAuthentication
//
//  Created by Federico on 07/01/2022.
//
//  Remember to add "Privacy - Face ID Usage Description" to the PLIST
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var unlocked = false
    @State private var text = "LOCKED"
    
    var body: some View {
        VStack {
            Text(text)
                .bold()
            .padding()
            
            Button("Authenticate") {
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Check whether it's possible to use biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {

            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    text = "UNLOCKED"
                } else {
                    text = "There was a problem!"
                }
            }
        } else {
            text = "Phone does not have biometrics"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
