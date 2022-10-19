//
//  SignUpView.swift
//  Brypto
//
//  Created by Bruke on 9/6/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var enteredUserName: String = ""
    @State private var enteredPassword: String = ""
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    
    var body: some View {
        VStack {
            bryptoHeader
            Text("username: \(userName)")
            Text("password: \(password)")
            login
            //faceIDSection
            loginButton
                .disabled(!aunthenticateLogin())
                .opacity(!aunthenticateLogin() ? 0.75 : 1)
            //orDivider
            signUpMessage
        }
        .navigationBarHidden(true)
//        .background(
//            Rectangle()
//                .fill(.white)
//                .cornerRadius(5)
//                .shadow(radius: 5)
//        )
//        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LoginView {
    var bryptoHeader: some View {
        VStack {
            Image("logo-transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("Brypto!")
                .font(.largeTitle.bold())
                .foregroundColor(Color("AccentColor"))
        }
    }
    
    var login: some View {
        VStack(spacing: -20) {
            Group {
                TextField("Username", text: $enteredUserName)
                SecureField("Password", text: $enteredPassword)
            }
            .disableAutocorrection(true)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                //.fill(.clear)
                    .stroke(Color.secondary, style: StrokeStyle(lineWidth: 2))
            )
            .padding()
        }
    }
    
    var faceIDSection: some View {
        Button {
            vm.authenticate()
        } label: {
            HStack {
                // remember section
                
                HStack(spacing: 3) {
                    Image(systemName: "faceid")
                    Text("Use Face ID")
                        .font(.headline)
                }
                .foregroundColor(.blue)
            }
        }

    }
    
    var loginButton: some View {
        Button {
            vm.login(enteredUserName: enteredUserName, enteredPassword: enteredPassword)
        } label: {
            Text("Login")
                .font(.headline.bold())
                .foregroundColor(Color("LaunchAccentColor"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(10)
                .padding()
        }
    }
    
    var orDivider: some View {
        HStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
            Text("OR")
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
        }
        .padding()
    }
    
    var signUpMessage: some View {
//        NavigationLink {
//            SignUpView()
//                .navigationBarBackButtonHidden(true)
//        } label: {
//            Text("Sign up")
//                .font(.headline.bold())
//                .foregroundColor(Color("LaunchAccentColor"))
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(.black)
//                .cornerRadius(10)
//                .padding()
//        }
        
        HStack {
            Text("Don't have an account?")
                .font(.subheadline.bold())
                .foregroundColor(Color.theme.secondaryText)
            NavigationLink {
                SignUpView()
            } label: {
                Text("Create a new one")
                    .font(.subheadline.bold())
                    .foregroundColor(.blue)
            }

        }
        .padding()
    }
    
    func aunthenticateLogin() -> Bool {
        if !enteredUserName.isEmpty && !enteredPassword.isEmpty {
            return true
        } else {
            return false
        }
    }
}
