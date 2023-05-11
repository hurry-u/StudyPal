//
//  LoginView.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var rememberMe = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 100)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .foregroundColor(.gray)
                    TextField("john.smith@gmail.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .foregroundColor(.gray)
                    SecureField("password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                Button(action: {
                    // Check if the email and password are valid
                    if email == "john.smith@gmail.com" && password == "password" {
                        print("Logged in successfully!")
                        isLoggedIn = true
                        if rememberMe {
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(password, forKey: "password")
                        }
                    } else {
                        // Show an error message
                        print("Error: Login failed")
                    }
                }) {
                    NavigationLink(destination: GreetingView(username: "John"), isActive: $isLoggedIn) {
                        Text("Log in")
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Spacer()
                    Toggle(isOn: $rememberMe) {
                        Text("Remember me")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Sign up with Google
                    }) {
                        Image("google")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                            .background(Color("GoogleColor"))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        // Sign up with Facebook
                    }) {
                        Image("facebook")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                            .background(Color("FacebookColor"))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Navigate to the sign up screen
                }) {
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            .onAppear {
                if let email = UserDefaults.standard.string(forKey: "email"),
                   let password = UserDefaults.standard.string(forKey: "password") {
                    self.email = email
                    self.password = password
                    rememberMe = true
                    authenticateUser()
                }
            }
            .onDisappear {
                if !rememberMe {
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                }
            }
        }
    }
    
    func authenticateUser() {
        isLoggedIn = true
    }
}
    

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
