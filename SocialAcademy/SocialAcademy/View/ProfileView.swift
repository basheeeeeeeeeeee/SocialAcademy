//
//  ProfileView.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 6/8/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button("Sign Out", action: {
            try! Auth.auth().signOut()
        })
    }
}

#Preview {
    ProfileView()
}
