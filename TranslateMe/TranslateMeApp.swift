//
//  TranslateMeApp.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI
import FirebaseCore

@main
struct TranslateMeApp: App {
    
    @State var authViewModel: AuthViewModel = AuthViewModel()
    @State var translationViewModel: TranslationViewModel = TranslationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
            .environment(authViewModel)
            .environment(translationViewModel)
        }
    }
}
