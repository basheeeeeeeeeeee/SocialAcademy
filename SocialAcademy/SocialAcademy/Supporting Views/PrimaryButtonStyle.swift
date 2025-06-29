//
//  PrimaryButtonStyle.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 6/10/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if isEnabled {
                configuration.label
            } else {
                ProgressView()
            }
        }
        
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
