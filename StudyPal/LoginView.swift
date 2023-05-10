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
        NavigationView{
            VStack(spacing: 20){
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 100)
                }
                Spacer()
                
                VStack(){
                    Text("Email")
                        .foregroundColor(.gray)
                    TextField("",text:$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                }
                
                VStack(){
                    Text("Password")
                        .foregroundColor(.gray)
                    TextField("",text:$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
