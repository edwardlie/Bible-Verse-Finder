//
//  SignInEmailView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 4/7/25.
//

import SwiftUI

//@MainActor
//final class SignInEmailViewModel: Observable {
//    var email = ""
//    var password = ""
//    
//    // testing with testing@testing.com and password: testing
//    func signUp() async throws -> Bool {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("No email or password found.")
//            return false
//        }
//        try await AuthenticationManager.shared.createUser(email: email, password: password)
//        return true
//    }
//    
//    func signIn() async throws -> Bool {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("No email or password found.")
//            return false
//        }
//        let user = try await AuthenticationManager.shared.signInUser(email: email, password: password)
//        return true
//    }
//}

//struct SignInEmailView: View {
//    @State private var viewModel = SignInEmailViewModel()
//    @Binding var showSignInView: Bool
//    
//    var body: some View {
//        VStack {
//            TextField("Email...", text: $viewModel.email)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            SecureField("Password...", text: $viewModel.password)
//                .padding()
//                .background(Color.gray.opacity(0.4))
//                .cornerRadius(10)
//            
//            Button {
//                Task {
//                    do {
//                        showSignInView = try await !viewModel.signUp()
////                        showSignInView = true
//                        return
//                    } catch {
//                        print(error)
//                    }
//                    
//                    do {
//                        showSignInView = try await !viewModel.signIn()
////                        showSignInView = false
//                        return
//                    } catch {
//                        print(error)
//                    }
//                }
//            } label: {
//                Text("Sign In")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Sign In With Email")
//    }
//}
//
//#Preview {
//    NavigationStack {
//        SignInEmailView(showSignInView: .constant(false))
//    }
//}
