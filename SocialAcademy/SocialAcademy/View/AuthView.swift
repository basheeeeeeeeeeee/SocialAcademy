//
//  AuthView.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 6/8/25.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        if let user = viewModel.user {
            MainTabView()
                .environmentObject(ViewModelFactory(user: user))
        } else {
            NavigationView {
                SignInForm(viewModel: viewModel.makeSignInViewModel()) {
                    NavigationLink("Create Account", destination: CreateAccountForm(viewModel: viewModel.makeCreateAccountViewModel()))
                }
            }
        }
    }
}

extension AuthView {
    struct SignInForm<Footer: View>: View {
        @StateObject var viewModel: AuthViewModel.SignInViewModel
        @ViewBuilder let footer: () -> Footer
        
        var body: some View {
            Form {
                    TextField("Email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.password)
            } footer: {
                
                    Button("Sign In", action: viewModel.submit)
                    .buttonStyle(.primary)
                    footer()
                        .padding()
                
            }
            .onSubmit(viewModel.submit)
            .alert("Cannot Sign In", error: $viewModel.error)
            .disabled(viewModel.isWorking)
        }
    }
        
}

extension AuthView {
    struct CreateAccountForm: View {
        @StateObject var viewModel: AuthViewModel.CreateAccountViewModel
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            Form {
                TextField("Name", text: $viewModel.name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
            } footer: {
                Button("Create Account", action: viewModel.submit)
                    .buttonStyle(.primary)
                Button("Sign In", action: dismiss.callAsFunction)
                    .padding()
            }
            .onSubmit(viewModel.submit)
            .disabled(viewModel.isWorking)
        }
    }
}

extension AuthView {
    struct Form<Content: View, Footer: View>: View {
        @ViewBuilder let content: () -> Content
        @ViewBuilder let footer: () -> Footer
        
        var body: some View {
            VStack {
                Text("Socialcademy")
                    .font(.title.bold())
                content()
                    .padding()
                    .background(Color.secondary.opacity(0.15))
                    .cornerRadius(10)
                footer()
            }
            .navigationBarHidden(true)
            .padding()
        }
    }
}

#Preview {
    AuthView()
}
