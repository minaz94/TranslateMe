//
//  AuthenticationView.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI

struct AuthenticationView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @FocusState var isShowingKeyboard: Bool
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isSigningUp: Bool = false
    @State private var isTextFieldHidden = true
    @State var isNavigationg = false
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.teal.gradient.opacity(0.3))
                .onTapGesture {
                    isShowingKeyboard = false
                }
            VStack {
                Label("Translate Me", systemImage: "bubble.left.and.text.bubble.right.rtl")
                    .font(.custom("Avenir", size: 20))
                    .fontWeight(.semibold)
                Image("people")
                    .resizable()
                    .frame(width: 200, height: 100)
                    .padding()
                    .shadow(radius: 3)
                if !isTextFieldHidden {
                    TextField("Username", text: $username)
                        .font(.custom("Avenir", size: 20))
                        .focused($isShowingKeyboard)
                }
                
                TextField("Email", text: $email)
                    .font(.custom("Avenir", size: 20))
                    .focused($isShowingKeyboard)
                SecureField("Password", text: $password)
                    .font(.custom("Avenir", size: 20))
                    .focused($isShowingKeyboard)
                Button(action: {
                    isSigningUp.toggle()
                    isTextFieldHidden.toggle()
                }, label: {
                    Text(isSigningUp ? "Have an account?" : "Don't have an account?")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.medium)
                })
                .tint(.teal)
                .padding(.top)
                Spacer()
                Button(action: {
                    if isSigningUp {
                        Task {
                            do {
                                try await authViewModel.signUp(username: username, email: email, password: password)
                                print("we have a user")
                                isNavigationg = true
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }
                    } else {
                        Task {
                            do {
                                try await authViewModel.signIn(email: email, Password: password)
                                print("logged in")
                                isNavigationg = true
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                       , label: {
                    Text(isSigningUp ? "Sign Up" : "Log In")
                        .font(.custom("menlo", size: 20))
                        .bold()
                        .frame(width: 300)
                        .padding()
                        .background(.teal.gradient)
                        .foregroundStyle(.black.gradient)
                        .clipShape(.capsule)
                })
                
                .shadow(radius: 8)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isNavigationg) {
            TranslateView()
        }
    }
}

#Preview {
    AuthenticationView()
        .environment(AuthViewModel())
}
