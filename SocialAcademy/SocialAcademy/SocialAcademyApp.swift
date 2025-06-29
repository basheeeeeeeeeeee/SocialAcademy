//
//  SocialAcademyApp.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 5/24/25.
//

import SwiftUI
import Firebase

@main
struct SocialAcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
