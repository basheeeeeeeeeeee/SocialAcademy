//
//  Alert+Error.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 6/6/25.
//

import SwiftUI

struct Alert_Error: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private struct ErrorAlertViewModifier: ViewModifier {
    let title: String
    @Binding var error: Error?
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $error.hasValue, presenting: error, actions: { _ in }) { error in
                Text(error.localizedDescription) }
    }
}

private extension Optional {
    var hasValue: Bool {
        get { self != nil }
        set { self = newValue ? self : nil }
    }
}

extension View {
    func alert(_ title: String, error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(title: title, error: error))
    }
}

#Preview {
    Alert_Error()
}
